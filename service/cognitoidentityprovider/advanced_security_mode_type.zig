pub const AdvancedSecurityModeType = enum {
    off,
    audit,
    enforced,

    pub const json_field_names = .{
        .off = "OFF",
        .audit = "AUDIT",
        .enforced = "ENFORCED",
    };
};
