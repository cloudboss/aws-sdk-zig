/// Proxy rule name and new desired position.
pub const ProxyRulePriority = struct {
    /// Where to move a proxy rule in a proxy rule group.
    new_position: ?i32,

    /// The descriptive name of the proxy rule. You can't change the name of a proxy
    /// rule after you create it.
    proxy_rule_name: ?[]const u8,

    pub const json_field_names = .{
        .new_position = "NewPosition",
        .proxy_rule_name = "ProxyRuleName",
    };
};
