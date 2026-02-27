const RuleBooleanExpression = @import("rule_boolean_expression.zig").RuleBooleanExpression;
const RuleDmarcExpression = @import("rule_dmarc_expression.zig").RuleDmarcExpression;
const RuleIpExpression = @import("rule_ip_expression.zig").RuleIpExpression;
const RuleNumberExpression = @import("rule_number_expression.zig").RuleNumberExpression;
const RuleStringExpression = @import("rule_string_expression.zig").RuleStringExpression;
const RuleVerdictExpression = @import("rule_verdict_expression.zig").RuleVerdictExpression;

/// The conditional expression used to evaluate an email for determining if a
/// rule action should be taken.
pub const RuleCondition = union(enum) {
    /// The condition applies to a boolean expression passed in this field.
    boolean_expression: ?RuleBooleanExpression,
    /// The condition applies to a DMARC policy expression passed in this field.
    dmarc_expression: ?RuleDmarcExpression,
    /// The condition applies to an IP address expression passed in this field.
    ip_expression: ?RuleIpExpression,
    /// The condition applies to a number expression passed in this field.
    number_expression: ?RuleNumberExpression,
    /// The condition applies to a string expression passed in this field.
    string_expression: ?RuleStringExpression,
    /// The condition applies to a verdict expression passed in this field.
    verdict_expression: ?RuleVerdictExpression,

    pub const json_field_names = .{
        .boolean_expression = "BooleanExpression",
        .dmarc_expression = "DmarcExpression",
        .ip_expression = "IpExpression",
        .number_expression = "NumberExpression",
        .string_expression = "StringExpression",
        .verdict_expression = "VerdictExpression",
    };
};
