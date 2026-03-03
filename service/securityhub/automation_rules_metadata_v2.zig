const AutomationRulesActionTypeObjectV2 = @import("automation_rules_action_type_object_v2.zig").AutomationRulesActionTypeObjectV2;
const RuleStatusV2 = @import("rule_status_v2.zig").RuleStatusV2;

/// Includes essential metadata information about automation rules.
pub const AutomationRulesMetadataV2 = struct {
    /// The list of action to be performed when the rule criteria is met.
    actions: ?[]const AutomationRulesActionTypeObjectV2 = null,

    /// The timestamp for when the automation rule was created.
    created_at: ?i64 = null,

    /// An explanation for the purpose and funcitonality of the automation rule.
    description: ?[]const u8 = null,

    /// The ARN of the automation rule.
    rule_arn: ?[]const u8 = null,

    /// The ID of the automation rule.
    rule_id: ?[]const u8 = null,

    /// The name of the automation rule.
    rule_name: ?[]const u8 = null,

    /// The value for the rule priority.
    rule_order: ?f32 = null,

    /// The status of the automation rule.
    rule_status: ?RuleStatusV2 = null,

    /// The timestamp for the most recent modification to the automation rule.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .created_at = "CreatedAt",
        .description = "Description",
        .rule_arn = "RuleArn",
        .rule_id = "RuleId",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .updated_at = "UpdatedAt",
    };
};
