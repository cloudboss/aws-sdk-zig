pub const StepStatus = enum {
    starting,
    executing,
    stopping,
    stopped,
    failed,
    succeeded,

    pub const json_field_names = .{
        .starting = "STARTING",
        .executing = "EXECUTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
