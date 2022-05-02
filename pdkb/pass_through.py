class PassThrough:
    """
    For storing information that is passed through from PDKBDDL to PDDL unmodified.
    """
    def __init__(self):
        self.requirements = None
        self.numeric_fluents = None
        self.func_init = None
        self.metric = None

PASS_THROUGH = PassThrough()
