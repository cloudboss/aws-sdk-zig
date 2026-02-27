pub const HealthState = enum {
    initial,
    healthy,
    unhealthy,

    pub const json_field_names = .{
        .initial = "INITIAL",
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
    };
};
