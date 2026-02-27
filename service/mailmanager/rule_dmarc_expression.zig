const RuleDmarcOperator = @import("rule_dmarc_operator.zig").RuleDmarcOperator;
const RuleDmarcPolicy = @import("rule_dmarc_policy.zig").RuleDmarcPolicy;

/// A DMARC policy expression. The condition matches if the given DMARC policy
/// matches that of the incoming email.
pub const RuleDmarcExpression = struct {
    /// The operator to apply to the DMARC policy of the incoming email.
    operator: RuleDmarcOperator,

    /// The values to use for the given DMARC policy operator. For the operator
    /// EQUALS, if multiple values are given, they are evaluated as an OR. That is,
    /// if any of the given values match, the condition is deemed to match. For the
    /// operator NOT_EQUALS, if multiple values are given, they are evaluated as an
    /// AND. That is, only if the email's DMARC policy is not equal to any of the
    /// given values, then the condition is deemed to match.
    values: []const RuleDmarcPolicy,

    pub const json_field_names = .{
        .operator = "Operator",
        .values = "Values",
    };
};
