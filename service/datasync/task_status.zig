pub const TaskStatus = enum {
    available,
    creating,
    queued,
    running,
    unavailable,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .creating = "CREATING",
        .queued = "QUEUED",
        .running = "RUNNING",
        .unavailable = "UNAVAILABLE",
    };
};
