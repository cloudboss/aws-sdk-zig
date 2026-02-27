pub const ProtectConfigurationRuleOverrideAction = enum {
    allow,
    block,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .block = "BLOCK",
    };
};
