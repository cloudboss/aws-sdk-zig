const IngressStringToEvaluate = @import("ingress_string_to_evaluate.zig").IngressStringToEvaluate;
const IngressStringOperator = @import("ingress_string_operator.zig").IngressStringOperator;

/// The structure for a string based condition matching on the incoming mail.
pub const IngressStringExpression = struct {
    /// The left hand side argument of a string condition expression.
    evaluate: IngressStringToEvaluate,

    /// The matching operator for a string condition expression.
    operator: IngressStringOperator,

    /// The right hand side argument of a string condition expression.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
