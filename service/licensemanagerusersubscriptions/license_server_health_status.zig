pub const LicenseServerHealthStatus = enum {
    healthy,
    unhealthy,
    not_applicable,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .not_applicable = "NOT_APPLICABLE",
    };
};
