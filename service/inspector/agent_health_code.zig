pub const AgentHealthCode = enum {
    idle,
    running,
    shutdown,
    unhealthy,
    throttled,
    unknown,

    pub const json_field_names = .{
        .idle = "IDLE",
        .running = "RUNNING",
        .shutdown = "SHUTDOWN",
        .unhealthy = "UNHEALTHY",
        .throttled = "THROTTLED",
        .unknown = "UNKNOWN",
    };
};
