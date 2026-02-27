const ProxyRulePhaseAction = @import("proxy_rule_phase_action.zig").ProxyRulePhaseAction;
const ProxyRuleCondition = @import("proxy_rule_condition.zig").ProxyRuleCondition;

/// Individual rules that define match conditions and actions for
/// application-layer traffic. Rules specify what to inspect (domains, headers,
/// methods) and what action to take (allow, deny, alert).
pub const CreateProxyRule = struct {
    /// Action to take.
    action: ?ProxyRulePhaseAction,

    /// Match criteria that specify what traffic attributes to examine. Conditions
    /// include operators (StringEquals, StringLike) and values to match against.
    conditions: ?[]const ProxyRuleCondition,

    /// A description of the proxy rule.
    description: ?[]const u8,

    /// Where to insert a proxy rule in a proxy rule group.
    insert_position: ?i32,

    /// The descriptive name of the proxy rule. You can't change the name of a proxy
    /// rule after you create it.
    proxy_rule_name: ?[]const u8,

    pub const json_field_names = .{
        .action = "Action",
        .conditions = "Conditions",
        .description = "Description",
        .insert_position = "InsertPosition",
        .proxy_rule_name = "ProxyRuleName",
    };
};
