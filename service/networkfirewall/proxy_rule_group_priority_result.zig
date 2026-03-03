/// Proxy rule group along with its priority.
pub const ProxyRuleGroupPriorityResult = struct {
    /// Priority of the proxy rule group in the proxy configuration.
    priority: ?i32 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .priority = "Priority",
        .proxy_rule_group_name = "ProxyRuleGroupName",
    };
};
