const AutomationRulesAction = @import("automation_rules_action.zig").AutomationRulesAction;
const AutomationRulesFindingFilters = @import("automation_rules_finding_filters.zig").AutomationRulesFindingFilters;
const RuleStatus = @import("rule_status.zig").RuleStatus;

/// Defines the configuration of an automation rule.
pub const AutomationRulesConfig = struct {
    /// One or more actions to update finding fields if a finding matches the
    /// defined criteria
    /// of the rule.
    actions: ?[]const AutomationRulesAction,

    /// A timestamp that indicates when the rule was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?i64,

    /// The principal that created a rule.
    created_by: ?[]const u8,

    /// A set of [Amazon Web Services
    /// Security Finding
    /// Format](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-findings-format.html) finding field attributes and corresponding expected values that
    /// Security Hub uses to filter findings. If a rule is enabled and a finding
    /// matches the conditions specified in
    /// this parameter, Security Hub applies the rule action to the finding.
    criteria: ?AutomationRulesFindingFilters,

    /// A description of the rule.
    description: ?[]const u8,

    /// Specifies whether a rule is the last to be applied with respect to a finding
    /// that matches the rule criteria. This is useful when a finding
    /// matches the criteria for multiple rules, and each rule has different
    /// actions. If a rule is terminal, Security Hub applies the rule action to a
    /// finding that matches
    /// the rule criteria and doesn't evaluate other rules for the finding. By
    /// default, a rule isn't terminal.
    is_terminal: ?bool,

    /// The Amazon Resource Name (ARN) of a rule.
    rule_arn: ?[]const u8,

    /// The name of the rule.
    rule_name: ?[]const u8,

    /// An integer ranging from 1 to 1000 that represents the order in which the
    /// rule action is
    /// applied to findings. Security Hub applies rules with lower values for this
    /// parameter
    /// first.
    rule_order: ?i32,

    /// Whether the rule is active after it is created. If
    /// this parameter is equal to `ENABLED`, Security Hub starts applying the rule
    /// to findings
    /// and finding updates after the rule is created.
    rule_status: ?RuleStatus,

    /// A timestamp that indicates when the rule was most recently updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: ?i64,

    pub const json_field_names = .{
        .actions = "Actions",
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .criteria = "Criteria",
        .description = "Description",
        .is_terminal = "IsTerminal",
        .rule_arn = "RuleArn",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .updated_at = "UpdatedAt",
    };
};
