from pathlib import Path

import os, sys, time, pickle

from pdkb.PostProcess.process_plan import StateSequence

def get_intermediate_states(pdkbddl_path: str, plan_path: str):
    """
    Use PDKBDDL file and plan file to create a file containing all intermediate states within the plan.

    The output file will be named {name}_intermediate_states, where {name} is the
    name of the plan file, and saved in the same directory as the plan file.

    :param pdkbddl_path: Path to PDKBDDL file, plan_path: Path to plan file

    """
    pdkbddl_file = Path(pdkbddl_path)
    plan_file = Path(plan_path)
    name = plan_path.replace(".1", "_intermediate_states") #assumes .1 file output from tfd
    intermediate_states = StateSequence(pdkbddl_file.read_text(), plan_file.read_text())
    Path(f"{name}").write_text(intermediate_states)

#get_intermediate_states('/home/aforsey/Desktop/pdkb-planning/examples/temporal/corridor_temporal.pdkbddl', '/home/aforsey/Desktop/pdkb-planning/solution_test.1')

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("\nUsage: python post_process.py <pdkbddl file path> <plan file path>\n")
        sys.exit(1)

    get_intermediate_states(pdkbddl_path=sys.argv[1], plan_path=sys.argv[2])

