/// The proxy rule group(s) to attach to the proxy configuration
pub const ProxyRuleGroupAttachment = struct {
    /// Where to insert a proxy rule group in a proxy configuration.
    insert_position: ?i32 = null,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .insert_position = "InsertPosition",
        .proxy_rule_group_name = "ProxyRuleGroupName",
    };
};
