import os, sys, time, pickle, re, copy

from pdkb.actions import *
from pdkb.problems import *

def StateSequence(pdkbddl:str, plan:str):
    problem = parse_pdkbddl(pdkbddl, input_is_file=False)
    problem.preprocess()
    domain_actions = combine_actions(problem.domain.actions)
    initial_props = set(problem.init.rmls)

    #initial_state = RetrieveInitialState(problem)
    plan_action_information = RetrievePlanActions(plan)
    state_updates = RetrieveStateUpdates(domain_actions, plan_action_information)
    intermediate_states = ApplyStateUpdates(initial_props, state_updates)

    return intermediate_states

def RetrievePlanActions(plan:str):
    """Takes in a plan string, returns plan_action_information list.
    Each list entry is a list of two values:
          - Str name of action executed
          - Float giving time point the action was executed
    """
    plan_action_information =[]
    lines = plan.split('\n')
    for line in lines:
        if line:
            time_stamp, name, duration = re.split(": \(| \)", line)
            plan_action_information.append([name, float(time_stamp)])
    return plan_action_information

def RetrieveStateUpdates(domain_actions, plan_action_information: [[str,float]]):
    """
    Inputs:
    domain_actions: a list of all CombinedDurativeActions for a domain
    plan_action_infomration: A list of lists. Output of RetrievePlanActions.

    Output:
    state_updates: dictionary with keys of time stamps at each point in time a conditional effect takes place, these
    time stamps correspond with the starts and ends of actions.

    The value of a time stamp is a list of two sub lists. The two sublists contain the positive conditoinal effects and the
    negative conditional effects, respectively. Conditional effects within each list are represented as CondEff objects.
    """

    action_objects = []
    for action_name, execution_time in plan_action_information:
        action_obj = next((a for a in domain_actions if a.name == action_name), None)
        action_objects.append([action_obj, execution_time])

    state_updates = {}

    for a, execution_time in action_objects:

        completion_time = execution_time + float(a.duration.duration)

        #add effects of start sub action at execution time
        if execution_time in state_updates: #check to see if key already exists
            state_updates[execution_time][0].extend(a.start_act_effs[0][0])
            state_updates[execution_time][1].extend(a.start_act_effs[0][1])
        else:
            state_updates[execution_time] = a.start_act.effs[0]

        #add effects of end sub action at completion time
        if completion_time in state_updates: #check to see if key already exists
            state_updates[completion_time][0].extend(a.end_act_effs[0][0])
            state_updates[completion_time][1].extend(a.end_act_effs[0][1])
        else:
            state_updates[completion_time] = a.end_act.effs[0]

    return state_updates


def ApplyStateUpdates(initial_props, state_updates):

    ordered_state_updates = dict(sorted(state_updates.items())) #order dictionary of states by time stamp

    current_state = copy.deepcopy(initial_props) #set current state to initial state
    state_str = "time:0.00 "+ "Propositions: "+", ".join([str(s) for s in current_state]) #initialize string of all states

    for time,cond_effects in ordered_state_updates.items():
        pos_effs, neg_effs = cond_effects
        fired_pos_effs = [eff for eff in pos_effs if conditions_satisfied(current_state, eff)]
        fired_neg_effs = [eff for eff in neg_effs if conditions_satisfied(current_state, eff)]

        current_state = apply_effects(current_state, [fired_pos_effs, fired_neg_effs])
        state_str += f"\ntime:{time} "+ "Propositions: "+", ".join([str(s) for s in current_state])

    return state_str

def conditions_satisfied(current_state, eff):
    pos_cond = [holds(current_state, cond) for cond in eff.condp]
    neg_cond = [holds(current_state, cond) for cond in eff.condn]

    if sum(pos_cond) == len(eff.condp) and sum(neg_cond) ==0: #if all positive conditions and no negative conditions hold
        return True
    return False

def holds(current_state, cond):
    return cond in current_state

def apply_effects(current_state, all_effs):
    fired_pos_effs, fired_neg_effs = all_effs

    for fired_neg_eff in fired_neg_effs:
        current_state.discard(fired_neg_eff.eff)

    for fired_pos_eff in fired_pos_effs:
        current_state.add(fired_pos_eff.eff)

    return current_state