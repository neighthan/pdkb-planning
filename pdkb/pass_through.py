class PassThrough:
    """
    For storing information that is passed through from PDKBDDL to PDDL unmodified.
    """
    def __init__(self):
        self.functions = None

PASS_THROUGH = PassThrough()
