const IngressIpToEvaluate = @import("ingress_ip_to_evaluate.zig").IngressIpToEvaluate;
const IngressIpOperator = @import("ingress_ip_operator.zig").IngressIpOperator;

/// The union type representing the allowed types for the left hand side of an
/// IP condition.
pub const IngressIpv4Expression = struct {
    /// The left hand side argument of an IP condition expression.
    evaluate: IngressIpToEvaluate,

    /// The matching operator for an IP condition expression.
    operator: IngressIpOperator,

    /// The right hand side argument of an IP condition expression.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
