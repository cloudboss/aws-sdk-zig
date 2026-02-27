pub const WorkflowRunStatus = enum {
    succeeded,
    failed,
    stopped,
    superseded,
    cancelled,
    not_run,
    validating,
    provisioning,
    in_progress,
    stopping,
    abandoned,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .superseded = "SUPERSEDED",
        .cancelled = "CANCELLED",
        .not_run = "NOT_RUN",
        .validating = "VALIDATING",
        .provisioning = "PROVISIONING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .abandoned = "ABANDONED",
    };
};
