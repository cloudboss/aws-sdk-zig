pub const IngestionJobStatus = enum {
    starting,
    in_progress,
    complete,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .starting = "STARTING",
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
        .failed = "FAILED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
