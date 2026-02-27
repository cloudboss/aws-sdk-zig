pub const HealthStatusFilter = enum {
    healthy,
    unhealthy,
    all,
    healthy_or_else_all,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .all = "ALL",
        .healthy_or_else_all = "HEALTHY_OR_ELSE_ALL",
    };
};
