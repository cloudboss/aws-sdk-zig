pub const SimulationStatus = enum {
    unknown,
    starting,
    started,
    stopping,
    stopped,
    failed,
    deleting,
    deleted,
    snapshot_in_progress,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .starting = "STARTING",
        .started = "STARTED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .snapshot_in_progress = "SNAPSHOT_IN_PROGRESS",
    };
};
