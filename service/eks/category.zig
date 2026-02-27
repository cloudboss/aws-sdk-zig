pub const Category = enum {
    upgrade_readiness,
    misconfiguration,

    pub const json_field_names = .{
        .upgrade_readiness = "UPGRADE_READINESS",
        .misconfiguration = "MISCONFIGURATION",
    };
};
