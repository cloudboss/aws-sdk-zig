pub const FleetProxyRuleType = enum {
    domain,
    ip,

    pub const json_field_names = .{
        .domain = "DOMAIN",
        .ip = "IP",
    };
};
