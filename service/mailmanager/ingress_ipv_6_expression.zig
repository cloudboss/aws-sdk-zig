const IngressIpv6ToEvaluate = @import("ingress_ipv_6_to_evaluate.zig").IngressIpv6ToEvaluate;
const IngressIpOperator = @import("ingress_ip_operator.zig").IngressIpOperator;

/// The union type representing the allowed types for the left hand side of an
/// IPv6 condition.
pub const IngressIpv6Expression = struct {
    /// The left hand side argument of an IPv6 condition expression.
    evaluate: IngressIpv6ToEvaluate,

    /// The matching operator for an IPv6 condition expression.
    operator: IngressIpOperator,

    /// The right hand side argument of an IPv6 condition expression.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
