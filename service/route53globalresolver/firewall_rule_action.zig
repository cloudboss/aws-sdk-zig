pub const FirewallRuleAction = enum {
    allow,
    alert,
    block,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .alert = "ALERT",
        .block = "BLOCK",
    };
};
