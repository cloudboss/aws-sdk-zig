/// Proxy rule group contained within a proxy configuration.
pub const ProxyConfigRuleGroup = struct {
    /// Priority of the proxy rule group in the proxy configuration.
    priority: ?i32,

    /// The Amazon Resource Name (ARN) of a proxy rule group.
    proxy_rule_group_arn: ?[]const u8,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8,

    /// Proxy rule group type.
    type: ?[]const u8,

    pub const json_field_names = .{
        .priority = "Priority",
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .type = "Type",
    };
};
