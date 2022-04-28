from pathlib import Path

from auto_argparse import parse_args_and_run_dec

from .planner import convert_to_pddl

@parse_args_and_run_dec
def convert_pdkbdll(pdkbdll_path: str):
    """
    Convert a PDKBDLL file to PDDL domain and problem files.

    The output files will be named {name}_domain.pddl and {name}_prob.pddl and
    saved in the current directory, where {name} is the name of the PDKBDLL file.
    :param pdkbdll_path: Path to PDKBDLL file.
    """
    pdkbdll_file = Path(pdkbdll_path)
    name = pdkbdll_file.name.replace(".pdkbdll", "")
    pddl = convert_to_pddl(pdkbdll_file.read_text())
    Path(f"{name}_domain.pddl").write_text(pddl["domain"])
    Path(f"{name}_problem.pddl").write_text(pddl["problem"])
