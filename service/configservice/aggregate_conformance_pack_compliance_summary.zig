const AggregateConformancePackComplianceCount = @import("aggregate_conformance_pack_compliance_count.zig").AggregateConformancePackComplianceCount;

/// Provides a summary of compliance based on either account ID or region.
pub const AggregateConformancePackComplianceSummary = struct {
    /// Returns an `AggregateConformancePackComplianceCount` object.
    compliance_summary: ?AggregateConformancePackComplianceCount,

    /// Groups the result based on Amazon Web Services account ID or Amazon Web
    /// Services Region.
    group_name: ?[]const u8,

    pub const json_field_names = .{
        .compliance_summary = "ComplianceSummary",
        .group_name = "GroupName",
    };
};
