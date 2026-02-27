const PolicyComplianceStatusType = @import("policy_compliance_status_type.zig").PolicyComplianceStatusType;

/// Describes the compliance status for the account. An account is considered
/// noncompliant if
/// it includes resources that are not protected by the specified policy or that
/// don't comply with
/// the policy.
pub const EvaluationResult = struct {
    /// Describes an Amazon Web Services account's compliance with the Firewall
    /// Manager policy.
    compliance_status: ?PolicyComplianceStatusType,

    /// Indicates that over 100 resources are noncompliant with the Firewall Manager
    /// policy.
    evaluation_limit_exceeded: bool = false,

    /// The number of resources that are noncompliant with the specified policy. For
    /// WAF and
    /// Shield Advanced policies, a resource is considered noncompliant if it is not
    /// associated with
    /// the policy. For security group policies, a resource is considered
    /// noncompliant if it doesn't
    /// comply with the rules of the policy and remediation is disabled or not
    /// possible.
    violator_count: i64 = 0,

    pub const json_field_names = .{
        .compliance_status = "ComplianceStatus",
        .evaluation_limit_exceeded = "EvaluationLimitExceeded",
        .violator_count = "ViolatorCount",
    };
};
