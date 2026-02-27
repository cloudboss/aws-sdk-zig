const AutomationRulesFindingFieldsUpdate = @import("automation_rules_finding_fields_update.zig").AutomationRulesFindingFieldsUpdate;
const AutomationRulesActionType = @import("automation_rules_action_type.zig").AutomationRulesActionType;

/// One or more actions that Security Hub takes when a finding matches the
/// defined criteria
/// of a rule.
pub const AutomationRulesAction = struct {
    /// Specifies that the automation rule action is an update to a finding field.
    finding_fields_update: ?AutomationRulesFindingFieldsUpdate,

    /// Specifies the type of action that Security Hub takes when a finding matches
    /// the defined criteria of a rule.
    type: ?AutomationRulesActionType,

    pub const json_field_names = .{
        .finding_fields_update = "FindingFieldsUpdate",
        .type = "Type",
    };
};
