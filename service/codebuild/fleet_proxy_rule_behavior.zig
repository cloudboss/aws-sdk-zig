pub const FleetProxyRuleBehavior = enum {
    allow_all,
    deny_all,

    pub const json_field_names = .{
        .allow_all = "ALLOW_ALL",
        .deny_all = "DENY_ALL",
    };
};
