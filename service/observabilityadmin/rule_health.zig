pub const RuleHealth = enum {
    healthy,
    unhealthy,
    provisioning,

    pub const json_field_names = .{
        .healthy = "HEALTHY",
        .unhealthy = "UNHEALTHY",
        .provisioning = "PROVISIONING",
    };
};
