const RuleStatus = @import("rule_status.zig").RuleStatus;

/// Metadata for automation rules in the calling account. The response includes
/// rules
/// with a `RuleStatus` of `ENABLED` and `DISABLED`.
pub const AutomationRulesMetadata = struct {
    /// A timestamp that indicates when the rule was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?i64 = null,

    /// The principal that created a rule.
    created_by: ?[]const u8 = null,

    /// A description of the rule.
    description: ?[]const u8 = null,

    /// Specifies whether a rule is the last to be applied with respect to a finding
    /// that matches the rule criteria. This is useful when a finding
    /// matches the criteria for multiple rules, and each rule has different
    /// actions. If a rule is terminal, Security Hub applies the rule action to a
    /// finding that matches
    /// the rule criteria and doesn't evaluate other rules for the finding. By
    /// default, a rule isn't terminal.
    is_terminal: ?bool = null,

    /// The Amazon Resource Name (ARN) for the rule.
    rule_arn: ?[]const u8 = null,

    /// The name of the rule.
    rule_name: ?[]const u8 = null,

    /// An integer ranging from 1 to 1000 that represents the order in which the
    /// rule action is
    /// applied to findings. Security Hub applies rules with lower values for this
    /// parameter
    /// first.
    rule_order: ?i32 = null,

    /// Whether the rule is active after it is created. If
    /// this parameter is equal to `ENABLED`, Security Hub starts applying the rule
    /// to findings
    /// and finding updates after the rule is created. To change the value of this
    /// parameter after creating a rule, use [
    /// `BatchUpdateAutomationRules`
    /// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateAutomationRules.html).
    rule_status: ?RuleStatus = null,

    /// A timestamp that indicates when the rule was most recently updated.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .description = "Description",
        .is_terminal = "IsTerminal",
        .rule_arn = "RuleArn",
        .rule_name = "RuleName",
        .rule_order = "RuleOrder",
        .rule_status = "RuleStatus",
        .updated_at = "UpdatedAt",
    };
};
