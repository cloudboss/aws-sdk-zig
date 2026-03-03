const ComplianceContributorCount = @import("compliance_contributor_count.zig").ComplianceContributorCount;

/// The number of Config rules or Amazon Web Services resources that are
/// compliant and noncompliant.
pub const ComplianceSummary = struct {
    /// The time that Config created the compliance
    /// summary.
    compliance_summary_timestamp: ?i64 = null,

    /// The number of Config rules or Amazon Web Services resources that are
    /// compliant, up to a maximum of 25 for rules and 100 for
    /// resources.
    compliant_resource_count: ?ComplianceContributorCount = null,

    /// The number of Config rules or Amazon Web Services resources that are
    /// noncompliant, up to a maximum of 25 for rules and 100 for
    /// resources.
    non_compliant_resource_count: ?ComplianceContributorCount = null,

    pub const json_field_names = .{
        .compliance_summary_timestamp = "ComplianceSummaryTimestamp",
        .compliant_resource_count = "CompliantResourceCount",
        .non_compliant_resource_count = "NonCompliantResourceCount",
    };
};
