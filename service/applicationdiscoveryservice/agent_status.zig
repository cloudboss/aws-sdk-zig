pub const AgentStatus = enum {
    healthy,
    unhealthy,
    running,
    unknown,
    blacklisted,
    shutdown,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .running = "RUNNING",
        .unknown = "UNKNOWN",
        .blacklisted = "BLACKLISTED",
        .shutdown = "SHUTDOWN",
    };
};
