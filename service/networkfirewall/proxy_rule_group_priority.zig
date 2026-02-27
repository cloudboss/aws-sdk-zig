/// Proxy rule group name and new desired position.
pub const ProxyRuleGroupPriority = struct {
    /// Where to move a proxy rule group in a proxy configuration.
    new_position: ?i32,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8,

    pub const json_field_names = .{
        .new_position = "NewPosition",
        .proxy_rule_group_name = "ProxyRuleGroupName",
    };
};
