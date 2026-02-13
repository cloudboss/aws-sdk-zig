pub const SignalType = enum {
    approve,
    reject,
    start_step,
    stop_step,
    @"resume",
    revoke,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .reject = "REJECT",
        .start_step = "START_STEP",
        .stop_step = "STOP_STEP",
        .@"resume" = "RESUME",
        .revoke = "REVOKE",
    };
};
