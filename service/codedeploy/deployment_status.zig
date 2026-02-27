pub const DeploymentStatus = enum {
    created,
    queued,
    in_progress,
    baking,
    succeeded,
    failed,
    stopped,
    ready,

    pub const json_field_names = .{
        .created = "CREATED",
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .baking = "BAKING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .ready = "READY",
    };
};
