pub const HyperParameterTuningJobStatus = enum {
    completed,
    in_progress,
    failed,
    stopped,
    stopping,
    deleting,
    delete_failed,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .stopping = "STOPPING",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
    };
};
