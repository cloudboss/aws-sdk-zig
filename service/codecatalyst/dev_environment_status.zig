pub const DevEnvironmentStatus = enum {
    pending,
    running,
    starting,
    stopping,
    stopped,
    failed,
    deleting,
    deleted,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .starting = "STARTING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
