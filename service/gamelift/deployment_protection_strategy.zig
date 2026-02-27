pub const DeploymentProtectionStrategy = enum {
    with_protection,
    ignore_protection,

    pub const json_field_names = .{
        .with_protection = "WITH_PROTECTION",
        .ignore_protection = "IGNORE_PROTECTION",
    };
};
