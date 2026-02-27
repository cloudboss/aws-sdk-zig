pub const EC2InstanceState = enum {
    pending,
    running,
    stopping,
    stopped,
    shutting_down,
    terminated,
    not_found,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .shutting_down = "SHUTTING_DOWN",
        .terminated = "TERMINATED",
        .not_found = "NOT_FOUND",
    };
};
