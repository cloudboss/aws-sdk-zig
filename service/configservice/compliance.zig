const ComplianceContributorCount = @import("compliance_contributor_count.zig").ComplianceContributorCount;
const ComplianceType = @import("compliance_type.zig").ComplianceType;

/// Indicates whether an Amazon Web Services resource or Config rule is
/// compliant and provides the number of contributors that affect the
/// compliance.
pub const Compliance = struct {
    /// The number of Amazon Web Services resources or Config rules that cause a
    /// result of `NON_COMPLIANT`, up to a maximum
    /// number.
    compliance_contributor_count: ?ComplianceContributorCount = null,

    /// Indicates whether an Amazon Web Services resource or Config rule is
    /// compliant.
    ///
    /// A resource is compliant if it complies with all of the Config rules that
    /// evaluate it. A resource is noncompliant if it does
    /// not comply with one or more of these rules.
    ///
    /// A rule is compliant if all of the resources that the rule
    /// evaluates comply with it. A rule is noncompliant if any of these
    /// resources do not comply.
    ///
    /// Config returns the `INSUFFICIENT_DATA` value
    /// when no evaluation results are available for the Amazon Web Services
    /// resource or Config rule.
    ///
    /// For the `Compliance` data type, Config supports
    /// only `COMPLIANT`, `NON_COMPLIANT`, and
    /// `INSUFFICIENT_DATA` values. Config does not
    /// support the `NOT_APPLICABLE` value for the
    /// `Compliance` data type.
    compliance_type: ?ComplianceType = null,

    pub const json_field_names = .{
        .compliance_contributor_count = "ComplianceContributorCount",
        .compliance_type = "ComplianceType",
    };
};
