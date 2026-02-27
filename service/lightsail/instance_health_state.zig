pub const InstanceHealthState = enum {
    initial,
    healthy,
    unhealthy,
    unused,
    draining,
    unavailable,

    pub const json_field_names = .{
        .initial = "Initial",
        .healthy = "Healthy",
        .unhealthy = "Unhealthy",
        .unused = "Unused",
        .draining = "Draining",
        .unavailable = "Unavailable",
    };
};
