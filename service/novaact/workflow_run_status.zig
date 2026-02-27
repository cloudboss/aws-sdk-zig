pub const WorkflowRunStatus = enum {
    running,
    succeeded,
    failed,
    timed_out,
    deleting,

    pub const json_field_names = .{
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .deleting = "DELETING",
    };
};
