const RuleCondition = @import("rule_condition.zig").RuleCondition;
const RuleStatus = @import("rule_status.zig").RuleStatus;

/// A summary of a link routing rule.
pub const LinkRoutingRuleSummary = struct {
    /// The conditions for the routing rule.
    conditions: RuleCondition,

    /// The timestamp of when the routing rule was created.
    created_at: i64,

    /// The priority of the routing rule.
    priority: i32,

    /// The unique identifier of the routing rule.
    rule_id: []const u8,

    /// The status of the routing rule.
    status: RuleStatus,

    /// The timestamp of when the routing rule was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .conditions = "conditions",
        .created_at = "createdAt",
        .priority = "priority",
        .rule_id = "ruleId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
