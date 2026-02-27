pub const DesiredState = enum {
    running,
    stopped,
    removed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .stopped = "STOPPED",
        .removed = "REMOVED",
    };
};
