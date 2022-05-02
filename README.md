# Multi-agent Epistemic Temporal Planning With Proper Doxastic Knowledge Bases

## [Original repo][orig_repo] description

> This repository houses the code for solving Multi-agent Epistemic Planning (MEP) problems using Proper Doxastic Knowledge Bases (PDKB). There are a number of components that may be useful on their own, including [working directing with PDKB's](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/kd45.py?at=default), [augmenting the MEP formalism](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/problems.py?at=default), or even just creating / dealing with [KD45 kripke structures](https://github.com/QuMuLab/PDKB-Planning/blob/master/pdkb/kripke.py?at=default).

> Eventually, more documentation will be added to the project, but feel free to [contact me](http://haz.ca/contact.html) if you have any questions. For a demo and more information on the project, [[click here](http://pdkb.haz.ca/)].

## Installation

```bash
git clone git@github.com:neighthan/pdkb-planning.git
cd pdkb-planning
pip install -e .
```

We recommend installing [TFD][TFD] for planning.

## Usage

The following scripts are installed
* `convert_pdkbddl`: takes a path to a PDKBDDL file as input and writes the converted PDDL domain and problem files into the current directory.

There are example files in `examples/temporal`. E.g. to test your installation, you can run

```bash
# from examples/temporal
convert_pdkbddl --pdkbddl_path corridor_temporal.pdkbddl
tfd corridor_temporal_domain.pddl  corridor_temporal_problem.pddl plan.txt
```

## Modifications

In order to easily add epistemic aspects to existing problems, we've added default values for the PDKBDDL-specific fields. If you just copy-paste your PDDL problem file into the bottom of the domain file, this should already be a valid PDKBDDL file. The defaults we set are
* `(:agents )` (no agents)
* `derive-condition: always` for durative actions (not added yet for normal actions; TFD requires all actions to be durative)
* `(:task valid_generation)` (generate a valid plan)
* `(:depth 1)` (level of belief nesting)
* `(:init-type complete)`
* `(:projection )` (no projection)

## Caveats
* TFD doesn't support duration inequalities.
* TFD may have issues with action durations involving operations applied to functions
* Problem types besides valid generation may not work.
* Because of how the parsing works, using [] for belief or <> for possibility on the same line where these characters are used in another way may cause issues. See `pdkb.problems:read_pdkbddl_file`, especially `replace_modal`.

[orig_repo]: https://github.com/QuMuLab/pdkb-planning
[TFD]: https://github.com/neighthan/tfd
