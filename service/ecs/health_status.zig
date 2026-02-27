pub const HealthStatus = enum {
    healthy,
    unhealthy,
    unknown,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .unknown = "UNKNOWN",
    };
};
