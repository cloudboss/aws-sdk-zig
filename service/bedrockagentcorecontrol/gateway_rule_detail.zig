const Action = @import("action.zig").Action;
const Condition = @import("condition.zig").Condition;
const GatewayRuleStatus = @import("gateway_rule_status.zig").GatewayRuleStatus;
const SystemManagedBlock = @import("system_managed_block.zig").SystemManagedBlock;

/// Detailed information about a gateway rule.
pub const GatewayRuleDetail = struct {
    /// The actions to take when the rule conditions are met.
    actions: []const Action,

    /// The conditions that must be met for the rule to apply.
    conditions: ?[]const Condition = null,

    /// The timestamp when the rule was created.
    created_at: i64,

    /// The description of the gateway rule.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway that the rule belongs to.
    gateway_arn: []const u8,

    /// The priority of the rule. Rules are evaluated in order of priority, with
    /// lower numbers evaluated first.
    priority: i32,

    /// The unique identifier of the gateway rule.
    rule_id: []const u8,

    /// The current status of the rule.
    status: GatewayRuleStatus,

    /// System-managed metadata for rules created by automated processes.
    system: ?SystemManagedBlock = null,

    /// The timestamp when the rule was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .actions = "actions",
        .conditions = "conditions",
        .created_at = "createdAt",
        .description = "description",
        .gateway_arn = "gatewayArn",
        .priority = "priority",
        .rule_id = "ruleId",
        .status = "status",
        .system = "system",
        .updated_at = "updatedAt",
    };
};
