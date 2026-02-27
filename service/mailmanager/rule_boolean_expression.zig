const RuleBooleanToEvaluate = @import("rule_boolean_to_evaluate.zig").RuleBooleanToEvaluate;
const RuleBooleanOperator = @import("rule_boolean_operator.zig").RuleBooleanOperator;

/// A boolean expression to be used in a rule condition.
pub const RuleBooleanExpression = struct {
    /// The operand on which to perform a boolean condition operation.
    evaluate: RuleBooleanToEvaluate,

    /// The matching operator for a boolean condition expression.
    operator: RuleBooleanOperator,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
    };
};
