
import os, glob, importlib
from itertools import combinations_with_replacement as comb_with_repl
from typing import Sequence

from pdkb.rml import Belief, Possible, RML, Literal, neg, parse_rml
from pdkb.kd45 import PDKB, kd_closure
from pdkb import ancillary

SIMPLIFY_INTROSPECTION = True
DEBUG = False


class Action(object):

    def __init__(self, name, depth, agents, props, akprops, derived_cond, extra_ancillary=()):
        self.name = name
        self.depth = depth
        self.agents = agents
        self.props = props
        self.akprops = akprops
        self.derived_cond = derived_cond

        self.pre = PDKB(depth, agents, props)
        self.npre = PDKB(depth, agents, props)
        self.effs = []

        # Detect all of the ancillary effects
        self.COMPILERS_POS = []
        self.COMPILERS_NEG = []

        for mod_name in ancillary.compute_modules() + list(extra_ancillary):
            mod = importlib.import_module(mod_name)
            self.COMPILERS_POS.extend(mod.COMPILERS_POS)
            self.COMPILERS_NEG.extend(mod.COMPILERS_NEG)

    def num_effs(self):
        count = 0
        for eff in self.effs:
            count += len(eff[0]) + len(eff[1])
        return count

    def applicable(self, state, agent=False):
        if DEBUG and not (self.pre.rmls <= state.rmls and 0 == len(self.npre.rmls & state.rmls)):
            print("\nDEBUG: Action %s is not applicable" % self.name)
            print("Precondition:\n%s" % str(self.pre))
            print("State:\n%s\n" % str(state))
        return (self.pre.rmls <= state.rmls) and (0 == len(self.npre.rmls & state.rmls))

    def possibly_applicable(self, state):
        assert False, "Not Implemented"

    def apply(self, state):
        return [self.apply_effect(state, eff[0], eff[1]) for eff in self.effs]

    def apply_effect(self, state, poseff, negeff):

        new_rmls = set([rml for rml in state.rmls])

        for condeff in negeff:
            if condeff.fires(state) and condeff.eff in new_rmls:
                new_rmls.remove(condeff.eff)

        for condeff in poseff:
            if condeff.fires(state):
                new_rmls.add(condeff.eff)

        new_state = PDKB(state.depth, state.agents, state.props)
        for rml in new_rmls:
            new_state.add_rml(rml)

        return new_state

    def expand(self, relevant_lits = None):
        relevant_lits = relevant_lits or set()
        for i in range(len(self.effs)):
            self.effs[i] = self._expand(self.effs[i][0], self.effs[i][1], relevant_lits)

    def project_effects(self, ag):
        for i in range(len(self.effs)):
            self.effs[i] = self._project(self.effs[i][0], ag)

    def project_pre(self, ag):
        assert 0 == len(self.npre), "Cannot project when there is lack-of-belief preconditions"
        new_pre = PDKB(self.pre.depth, self.pre.agents, self.pre.props)
        for rml in self.pre:
            if rml.agent == ag:
                if isinstance(rml, Possible):
                    self.npre.add_rml(neg(rml.rml))
                elif isinstance(rml, Belief):
                    new_pre.add_rml(rml.rml)
                else:
                    assert False, "Trying to project a Literal?"

            else:
                new_pre.add_rml(rml)
        self.pre = new_pre

    def _expand(self, effp, effn, relevant_lits):

        # Because a negated condition can produce a positive (through belief closure)
        #  and a positive condition can produce a negative (through lack of knowledge),
        #  we need to keep a mix of both around for the closure.
        condleft = [(True, cond) for cond in effp] + [(False, cond) for cond in effn]

        newposconds = set()
        newnegconds = set()

        while condleft:

            (is_pos, condeff) = condleft.pop(0)

            if is_pos and (condeff not in newposconds):
                if len(relevant_lits) == 0 or condeff.eff in relevant_lits:
                    newposconds.add(condeff)
                    for compiler in self.COMPILERS_POS:
                        condleft.extend(compiler(condeff, self))

            elif (not is_pos) and (condeff not in newnegconds):
                if len(relevant_lits) == 0 or condeff.eff in relevant_lits:
                    newnegconds.add(condeff)
                    for compiler in self.COMPILERS_NEG:
                        condleft.extend(compiler(condeff, self))

        return (list(newposconds), list(newnegconds))

    def _project(self, effp, ag):
        valid_effs = [x for x in effp if x.uniform(ag, self.akprops)]
        projected_effs = [eff.project(ag, self.akprops) for eff in valid_effs]
        newposconds = []
        newnegconds = []
        for (ispos, eff) in projected_effs:
            if ispos:
                newposconds.append(eff)
            else:
                newnegconds.append(eff)

        return (newposconds, newnegconds)

    def new_nondet_effect(self):
        self.effs.append((set(), set()))

    def add_pos_effect(self, condp, condn, lit, cond_ma_cond=False):
        self.effs[-1][0].add(CondEff(condp, condn, lit, cond_ma_cond))

    def add_neg_effect(self, condp, condn, lit, cond_ma_cond=False):
        self.effs[-1][1].add(CondEff(condp, condn, lit, cond_ma_cond))

    def add_pre(self, rml, negate=False):
        if negate:
            self.npre.add_rml(rml)
        else:
            self.pre.add_rml(rml)

    def pddl(self):
        lines = [
            f"  (:action {self.name}",
            "    :parameters ()",
            "    :precondition (and",
            *[f"      ({rml.pddl()})" for rml in self.pre],
            *[f"      (not ({rml.pddl()}))" for rml in self.npre],
            "    )",
        ]
        if len(self.effs) > 1:
            # haven't tested the updated to effects with oneof; if there's an issue here,
            # rollback to the old version
            lines.append("\n    :effect (oneof")
            for pos_eff, neg_eff in self.effs:
                lines.extend([
                    "      (and",
                    *[cond.pddl(" " * 8) for cond in pos_eff],
                    *[cond.pddl(" " * 8, negate=True) for cond in neg_eff],
                    "      )",
                ])
            lines.append("    )")
        else:
            pos_effects = sorted(self.effs[0][0], key=lambda e: e.id())
            neg_effects = sorted(self.effs[0][1], key=lambda e: e.id())
            effects = [(e, False) for e in pos_effects] + [(e, True) for e in neg_effects]
            lines.extend([
                "\n    :effect (and",
                *[effect.pddl("      ", negate=negate) for effect, negate in effects],
                "    )",
            ])
        lines.append("  )")
        return "\n".join(lines)


class DurativeAction(Action):
    def __init__(self, name, depth, agents, props, akprops, derived_cond, extra_ancillary=[], duration=None):
        super().__init__(name, depth, agents, props, akprops, derived_cond, extra_ancillary)
        assert duration is not None
        self.duration = duration


def _rml_to_pddl(rml, time: str, negate: bool):
    if isinstance(rml, (Literal, Belief, Possible)):
        if negate:
            return f"({time} (not ({rml.pddl()})))"
        else:
            return f"({time} ({rml.pddl()}))"
    assert False


class CombinedDurativeAction:
    """Only used for outputting PDDL; not an Action subclass."""
    def __init__(self, actions: Sequence[DurativeAction]):
        times = [a.name.split("_")[-1] for a in actions]
        self.start_act = actions[times.index("start")]
        self.overall_act = actions[times.index("overall")]
        self.end_act = actions[times.index("end")]
        self.name = self.start_act.name.replace("_start", "")
        self.duration = self.start_act.duration

    def pddl(self) -> str:
        lines = [
            f"  (:durative-action {self.name}",
            "    :parameters ()",
            f"    :duration {self.duration}",
            "    :condition (and",
            *[f"      {_rml_to_pddl(rml, 'at start', False)}" for rml in self.start_act.pre],
            *[f"      {_rml_to_pddl(rml, 'at start', True)}" for rml in self.start_act.npre],
            *[f"      {_rml_to_pddl(rml, 'over all', False)}" for rml in self.overall_act.pre],
            *[f"      {_rml_to_pddl(rml, 'over all', True)}" for rml in self.overall_act.npre],
            *[f"      {_rml_to_pddl(rml, 'at end', False)}" for rml in self.end_act.pre],
            *[f"      {_rml_to_pddl(rml, 'at end', True)}" for rml in self.end_act.npre],
            "    )",
        ]

        assert self.overall_act.effs == [([], [])]
        if len(self.start_act.effs) > 1 or len(self.end_act.effs) > 1:
            raise NotImplementedError(
                "Durative actions don't support non-deterministic effects yet."
            )
        else:
            pos_start_effects = sorted(self.start_act.effs[0][0], key=lambda e: e.id())
            neg_start_effects = sorted(self.start_act.effs[0][1], key=lambda e: e.id())
            pos_end_effects = sorted(self.end_act.effs[0][0], key=lambda e: e.id())
            neg_end_effects = sorted(self.end_act.effs[0][1], key=lambda e: e.id())
            start_effects = [(e, False) for e in pos_start_effects] + [(e, True) for e in neg_start_effects]
            end_effects = [(e, False) for e in pos_end_effects] + [(e, True) for e in neg_end_effects]
            lines.extend([
                "\n    :effect (and",
                *[f"      {effect.pddl(negate=negate, time='at start')}" for effect, negate in start_effects],
                *[f"      {effect.pddl(negate=negate, time='at end')}" for effect, negate in end_effects],
                "    )",
            ])
        lines.append("  )")
        return "\n".join(lines)


class CondEff(object):

    def __init__(self, condp, condn, lit, cond_ma_cond, reason=None):
        assert isinstance(condp, PDKB)
        assert isinstance(condn, PDKB)
        assert isinstance(lit, RML)

        if SIMPLIFY_INTROSPECTION:
            condp.rmls = set([rml.merge_modalities() for rml in condp.rmls])
            condn.rmls = set([rml.merge_modalities() for rml in condn.rmls])
            lit = lit.merge_modalities()

        self.condp = condp
        self.condn = condn
        self.eff = lit

        self.ma_cond = cond_ma_cond
        self.reason = reason

        self.hash = hash('/'.join(map(str, [condp, condn, lit])))

    def uniform(self, ag, akprops):
        # Can't project to lack of knowledge
        if len(self.condn.rmls) != 0:
            return False

        # Can't project if there is an outer belief for another agent
        if (self.eff.agent != ag) and not self.eff.is_ak(akprops):
            return False

        for rml in self.condp:
            if (rml.agent != ag) and not rml.is_ak(akprops):
                return False

        return True

    def project(self, ag, akprops):
        condp = PDKB(self.condp.depth, self.condp.agents, self.condp.props)
        condn = PDKB(self.condp.depth, self.condp.agents, self.condp.props)

        for rml in self.condp:
            if isinstance(rml, Possible):
                condn.add_rml(neg(rml.rml))
            elif isinstance(rml, Belief):
                condp.add_rml(rml.rml)
            elif rml.is_ak(akprops):
                condp.add_rml(rml)
            else:
                assert False, "Trying to project a Literal?"

        if isinstance(self.eff, Possible):
            return (False, CondEff(condp, condn, neg(self.eff.rml), self.ma_cond, self.reason))
        elif isinstance(self.eff, Belief):
            return (True, CondEff(condp, condn, self.eff.rml, self.ma_cond, self.reason))
        elif self.eff.is_ak(akprops):
            return (True, CondEff(condp, condn, self.eff, self.ma_cond, self.reason))
        else:
            assert False, "Bad effect for projection?"

    def fires(self, state):
        return (self.condp.rmls <= state.rmls) and (0 == len(self.condn.rmls & state.rmls))

    def reason_string(self):
        to_ret = str(self)
        if self.reason:
            to_ret += "\nDeduced using %s from the %s condeff: %s" % (self.reason[0], self.reason[1], str(self.reason[2]))
        return to_ret

    def id(self):
        return str(abs(hash(str(hash(self)))))[:5]

    def __str__(self):
        return "{%s} / {%s} --> %s" % (', '.join(map(str, self.condp.rmls)),
                                       ', '.join(map(str, self.condn.rmls)),
                                       str(self.eff))

    def __hash__(self):
        return self.hash

    def __cmp__(self, other):
        return self.__hash__() == other.__hash__()

    def __eq__(self, other):
        return self.__cmp__(other)

    def __ne__(self, other):
        return not self.__cmp__(other)

    def __lt__(self, other):
        return self.hash < other.hash

    @property
    def depth(self):
        return max([rml.get_depth() for rml in self.condp.rmls | self.condn.rmls | set([self.eff])])

    def pddl(self, spacing = '', negate = False, time: str=""):

        # Set to true if you want to export effects in the style of epddl
        #  Note that this will not be compatible with classical planners
        EPDDL = False

        delim = '\n' + spacing + '           '

        if self.reason:
            reason = "  ; #%s: <==%s== %s (%s)" % (self.id(), self.reason[0], self.reason[2].id(), self.reason[1])
        else:
            reason = "  ; #%s: origin" % self.id()

        def rml_to_pddl(rml, negate: bool):
            assert isinstance(rml, (Literal, Belief, Possible))
            if time:
                if negate:
                    return f"({time} (not ({rml.pddl()})))"
                return f"({time} ({rml.pddl()}))"
            if negate:
                return f"(not ({rml.pddl()}))"
            return f"({rml.pddl()})"

        if (not self.condp.rmls) and (not self.condn.rmls):
            if negate:
                if EPDDL:
                    return spacing + "<{(True)} {(not (%s))}>" % self.eff.pddl() + reason
                else:
                    return spacing + rml_to_pddl(self.eff, negate) + reason
            else:
                if EPDDL:
                    return spacing + "<{(True)} {(%s)}>" % self.eff.pddl() + reason
                else:
                    return spacing + rml_to_pddl(self.eff, negate) + reason

        cond_size = len(self.condp) + len(self.condn)
        condition = delim.join([rml_to_pddl(rml, False) for rml in self.condp] + \
                               [rml_to_pddl(rml, True) for rml in self.condn])
        if cond_size > 1:
            condition = "(and %s)" % condition

        if negate:
            if EPDDL:
                return spacing + "<{%s}\n%s      {(not (%s))}>" % (condition, spacing, self.eff.pddl()) + reason
            else:
                return spacing + "(when (and %s)\n%s      %s)" % (condition, spacing, rml_to_pddl(self.eff, negate)) + reason
        else:
            if EPDDL:
                return spacing + "<{%s}\n%s      {(%s)}>" % (condition, spacing, self.eff.pddl()) + reason
            else:
                return spacing + "(when (and %s)\n%s      %s)" % (condition, spacing, rml_to_pddl(self.eff, negate)) + reason




if __name__ == '__main__':
    a = Action('foo', 2, [1,2], list(map(Literal, ['p', 'q',])), True)
    a.add_pre(Belief(1, Literal('p')))
    a.add_pre(Belief(2, Literal('p')))
    a.new_nondet_effect()
    p1 = PDKB(2, [1,2], list(map(Literal, ['p', 'q',])))
    p2 = PDKB(2, [1,2], list(map(Literal, ['p', 'q',])))
    p3 = PDKB(2, [1,2], list(map(Literal, ['p', 'q',])))
    p4 = PDKB(2, [1,2], list(map(Literal, ['p', 'q',])))
    pempty = PDKB(2, [1,2], list(map(Literal, ['p', 'q',])))
    p1.add_rml(Belief(1, Literal('p')))
    p1.add_rml(Belief(1, Possible(2, neg(Literal('p')))))
    lit = Belief(2, Literal('q'))
    p2.add_rml(Belief(2, Literal('q')))
    p3.add_rml(Literal('p'))
    p4.add_rml(Literal('q'))

    a.add_pos_effect(p3, pempty, Literal('q'))
    a.add_pos_effect(p1, pempty, lit)
    a.new_nondet_effect()
    a.add_neg_effect(pempty, p1, lit)
    a.add_pos_effect(p1, pempty, lit)

    print(a.pddl())
    print()

    a.expand()

    print(a.pddl())

    i = 0

    for (peff, neff) in a.effs:
        print()
        print(" -{ Non-det effect }-")
        print("Positive")
        for condeff in peff:
            i += 1
            print()
            print("%d: %s" % (i, condeff.reason_string()))
        print()
        print("Negative")
        for condeff in neff:
            i += 1
            print()
            print("%d: %s" % (i, condeff.reason_string()))

    print()

    lit2 = Belief(2, Literal('q'))
    print("%s --> %s" % (str(p1), str(lit2)))
    from pdkb.ancillary.mutual_awareness import commonly_known_effect
    for ce in commonly_known_effect(CondEff(p1, pempty, lit2, False), [1,2], 3, 'pq', 'pos', True):
        print(ce[1].pddl())
        print()
