pub const InstanceStateName = enum {
    pending,
    running,
    shutting_down,
    terminated,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "PENDING",
        .running = "RUNNING",
        .shutting_down = "SHUTTING_DOWN",
        .terminated = "TERMINATED",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
    };
};
