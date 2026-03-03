const RoutingRuleAction = @import("routing_rule_action.zig").RoutingRuleAction;
const RoutingRuleCondition = @import("routing_rule_condition.zig").RoutingRuleCondition;

/// Represents a routing rule.
pub const RoutingRule = struct {
    /// The routing rule action.
    actions: ?[]const RoutingRuleAction = null,

    /// The routing rule condition.
    conditions: ?[]const RoutingRuleCondition = null,

    /// The routing rule priority.
    priority: ?i32 = null,

    /// The routing rule ARN.
    routing_rule_arn: ?[]const u8 = null,

    /// The routing rule ID.
    routing_rule_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .conditions = "Conditions",
        .priority = "Priority",
        .routing_rule_arn = "RoutingRuleArn",
        .routing_rule_id = "RoutingRuleId",
    };
};
