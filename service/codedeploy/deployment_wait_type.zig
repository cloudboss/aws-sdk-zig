pub const DeploymentWaitType = enum {
    ready_wait,
    termination_wait,

    pub const json_field_names = .{
        .ready_wait = "READY_WAIT",
        .termination_wait = "TERMINATION_WAIT",
    };
};
