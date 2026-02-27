pub const EvaluationJobStatus = enum {
    in_progress,
    completed,
    failed,
    stopping,
    stopped,
    deleting,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .deleting = "DELETING",
    };
};
