pub const EarthObservationJobStatus = enum {
    /// INITIALIZING
    initializing,
    /// IN_PROGRESS
    in_progress,
    /// STOPPING
    stopping,
    /// COMPLETED
    completed,
    /// STOPPED
    stopped,
    /// FAILED
    failed,
    /// DELETING
    deleting,
    /// DELETED
    deleted,

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .completed = "COMPLETED",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
