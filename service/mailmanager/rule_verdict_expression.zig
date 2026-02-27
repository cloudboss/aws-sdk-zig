const RuleVerdictToEvaluate = @import("rule_verdict_to_evaluate.zig").RuleVerdictToEvaluate;
const RuleVerdictOperator = @import("rule_verdict_operator.zig").RuleVerdictOperator;
const RuleVerdict = @import("rule_verdict.zig").RuleVerdict;

/// A verdict expression is evaluated against verdicts of the email.
pub const RuleVerdictExpression = struct {
    /// The verdict to evaluate in a verdict condition expression.
    evaluate: RuleVerdictToEvaluate,

    /// The matching operator for a verdict condition expression.
    operator: RuleVerdictOperator,

    /// The values to match with the email's verdict using the given operator. For
    /// the EQUALS operator, if multiple values are given, the condition is deemed
    /// to match if any of the given verdicts match that of the email. For the
    /// NOT_EQUALS operator, if multiple values are given, the condition is deemed
    /// to match of none of the given verdicts match the verdict of the email.
    values: []const RuleVerdict,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
