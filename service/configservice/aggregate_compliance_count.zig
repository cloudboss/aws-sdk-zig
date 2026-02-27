const ComplianceSummary = @import("compliance_summary.zig").ComplianceSummary;

/// Returns the number of compliant and noncompliant rules for one
/// or more accounts and regions in an aggregator.
pub const AggregateComplianceCount = struct {
    /// The number of compliant and noncompliant Config
    /// rules.
    compliance_summary: ?ComplianceSummary,

    /// The 12-digit account ID or region based on the GroupByKey
    /// value.
    group_name: ?[]const u8,

    pub const json_field_names = .{
        .compliance_summary = "ComplianceSummary",
        .group_name = "GroupName",
    };
};
