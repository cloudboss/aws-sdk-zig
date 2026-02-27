const RuleType = @import("rule_type.zig").RuleType;

/// Summary information of this case rule. In the Amazon Connect admin website,
/// case rules are known as *case field conditions*. For more information about
/// case field conditions, see [Add case field conditions to a case
/// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
pub const CaseRuleSummary = struct {
    /// The Amazon Resource Name (ARN) of the case rule.
    case_rule_arn: []const u8,

    /// Unique identifier of a case rule.
    case_rule_id: []const u8,

    /// Description of a case rule.
    description: ?[]const u8,

    /// Name of the case rule.
    name: []const u8,

    /// Possible types for a rule.
    rule_type: RuleType,

    pub const json_field_names = .{
        .case_rule_arn = "caseRuleArn",
        .case_rule_id = "caseRuleId",
        .description = "description",
        .name = "name",
        .rule_type = "ruleType",
    };
};
