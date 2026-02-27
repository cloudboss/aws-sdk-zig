pub const CollectorHealth = enum {
    collector_healthy,
    collector_unhealthy,

    pub const json_field_names = .{
        .collector_healthy = "COLLECTOR_HEALTHY",
        .collector_unhealthy = "COLLECTOR_UNHEALTHY",
    };
};
