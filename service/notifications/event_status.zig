pub const EventStatus = enum {
    healthy,
    unhealthy,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
    };
};
