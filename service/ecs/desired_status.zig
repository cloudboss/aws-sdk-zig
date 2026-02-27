pub const DesiredStatus = enum {
    running,
    pending,
    stopped,

    pub const json_field_names = .{
        .running = "RUNNING",
        .pending = "PENDING",
        .stopped = "STOPPED",
    };
};
