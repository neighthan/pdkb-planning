from pathlib import Path

from auto_argparse import parse_args_and_run_dec

from pdkb.planner import convert_to_pddl

@parse_args_and_run_dec
def convert_pdkbddl(pdkbddl_path: str):
    """
    Convert a PDKBDDL file to PDDL domain and problem files.

    The output files will be named {name}_domain.pddl and {name}_prob.pddl and
    saved in the current directory, where {name} is the name of the PDKBDDL file.
    :param pdkbddl_path: Path to PDKBDDL file.
    """
    pdkbddl_file = Path(pdkbddl_path)
    name = pdkbddl_file.name.replace(".pdkbddl", "")
    pddl = convert_to_pddl(pdkbddl_file.read_text())
    Path(f"{name}_domain.pddl").write_text(pddl["domain"])
    Path(f"{name}_problem.pddl").write_text(pddl["problem"])
