const RuleStringToEvaluate = @import("rule_string_to_evaluate.zig").RuleStringToEvaluate;
const RuleStringOperator = @import("rule_string_operator.zig").RuleStringOperator;

/// A string expression is evaluated against strings or substrings of the email.
pub const RuleStringExpression = struct {
    /// The string to evaluate in a string condition expression.
    evaluate: RuleStringToEvaluate,

    /// The matching operator for a string condition expression.
    operator: RuleStringOperator,

    /// The string(s) to be evaluated in a string condition expression. For all
    /// operators, except for NOT_EQUALS, if multiple values are given, the values
    /// are processed as an OR. That is, if any of the values match the email's
    /// string using the given operator, the condition is deemed to match. However,
    /// for NOT_EQUALS, the condition is only deemed to match if none of the given
    /// strings match the email's string.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
