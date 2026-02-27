const RuleIpToEvaluate = @import("rule_ip_to_evaluate.zig").RuleIpToEvaluate;
const RuleIpOperator = @import("rule_ip_operator.zig").RuleIpOperator;

/// An IP address expression matching certain IP addresses within a given range
/// of IP addresses.
pub const RuleIpExpression = struct {
    /// The IP address to evaluate in this condition.
    evaluate: RuleIpToEvaluate,

    /// The operator to evaluate the IP address.
    operator: RuleIpOperator,

    /// The IP CIDR blocks in format "x.y.z.w/n" (eg 10.0.0.0/8) to match with the
    /// email's IP address. For the operator CIDR_MATCHES, if multiple values are
    /// given, they are evaluated as an OR. That is, if the IP address is contained
    /// within any of the given CIDR ranges, the condition is deemed to match. For
    /// NOT_CIDR_MATCHES, if multiple CIDR ranges are given, the condition is deemed
    /// to match if the IP address is not contained in any of the given CIDR ranges.
    values: []const []const u8,

    pub const json_field_names = .{
        .evaluate = "Evaluate",
        .operator = "Operator",
        .values = "Values",
    };
};
