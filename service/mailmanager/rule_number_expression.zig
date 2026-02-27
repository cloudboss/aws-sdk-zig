const RuleNumberToEvaluate = @import("rule_number_to_evaluate.zig").RuleNumberToEvaluate;
const RuleNumberOperator = @import("rule_number_operator.zig").RuleNumberOperator;

/// A number expression to match numeric conditions with integers from the
/// incoming email.
pub const RuleNumberExpression = struct {
    /// The number to evaluate in a numeric condition expression.
    evaluate: RuleNumberToEvaluate,

    /// The operator for a numeric condition expression.
    operator: RuleNumberOperator,

    /// The value to evaluate in a numeric condition expression.
    value: f64,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .value = "Value",
    };
};
