pub const AdvancedSecurityEnabledModeType = enum {
    audit,
    enforced,

    pub const json_field_names = .{
        .audit = "AUDIT",
        .enforced = "ENFORCED",
    };
};
