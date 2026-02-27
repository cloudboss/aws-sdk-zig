const ProxyRulesByRequestPhase = @import("proxy_rules_by_request_phase.zig").ProxyRulesByRequestPhase;
const Tag = @import("tag.zig").Tag;

/// Collections of related proxy filtering rules. Rule groups help you manage
/// and reuse sets of rules across multiple proxy configurations.
pub const ProxyRuleGroup = struct {
    /// Time the Proxy Rule Group was created.
    create_time: ?i64,

    /// Time the Proxy Rule Group was deleted.
    delete_time: ?i64,

    /// A description of the proxy rule group.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a proxy rule group.
    proxy_rule_group_arn: ?[]const u8,

    /// The descriptive name of the proxy rule group. You can't change the name of a
    /// proxy rule group after you create it.
    proxy_rule_group_name: ?[]const u8,

    /// Individual rules that define match conditions and actions for
    /// application-layer traffic. Rules specify what to inspect (domains, headers,
    /// methods) and what action to take (allow, deny, alert).
    rules: ?ProxyRulesByRequestPhase,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .delete_time = "DeleteTime",
        .description = "Description",
        .proxy_rule_group_arn = "ProxyRuleGroupArn",
        .proxy_rule_group_name = "ProxyRuleGroupName",
        .rules = "Rules",
        .tags = "Tags",
    };
};
