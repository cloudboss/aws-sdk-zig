pub const VectorEnrichmentJobStatus = enum {
    initializing,
    in_progress,
    stopping,
    stopped,
    completed,
    failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
