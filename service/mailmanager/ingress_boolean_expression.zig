const IngressBooleanToEvaluate = @import("ingress_boolean_to_evaluate.zig").IngressBooleanToEvaluate;
const IngressBooleanOperator = @import("ingress_boolean_operator.zig").IngressBooleanOperator;

/// The structure for a boolean condition matching on the incoming mail.
pub const IngressBooleanExpression = struct {
    /// The operand on which to perform a boolean condition operation.
    evaluate: IngressBooleanToEvaluate,

    /// The matching operator for a boolean condition expression.
    operator: IngressBooleanOperator,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
    };
};
