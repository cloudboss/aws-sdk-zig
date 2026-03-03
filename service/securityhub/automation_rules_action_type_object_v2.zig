const AutomationRulesActionTypeV2 = @import("automation_rules_action_type_v2.zig").AutomationRulesActionTypeV2;

/// Allows you to customize security response workflows.
pub const AutomationRulesActionTypeObjectV2 = struct {
    /// The category of action to be executed by the automation rule.
    @"type": ?AutomationRulesActionTypeV2 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
