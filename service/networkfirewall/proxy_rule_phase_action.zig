pub const ProxyRulePhaseAction = enum {
    allow,
    deny,
    alert,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .deny = "DENY",
        .alert = "ALERT",
    };
};
