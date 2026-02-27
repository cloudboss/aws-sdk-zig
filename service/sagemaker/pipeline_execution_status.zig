pub const PipelineExecutionStatus = enum {
    executing,
    stopping,
    stopped,
    failed,
    succeeded,

    pub const json_field_names = .{
        .executing = "EXECUTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
    };
};
