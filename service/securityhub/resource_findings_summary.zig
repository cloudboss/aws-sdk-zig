const ResourceSeverityBreakdown = @import("resource_severity_breakdown.zig").ResourceSeverityBreakdown;

/// A list of summaries for all finding types on a resource.
pub const ResourceFindingsSummary = struct {
    /// The category or classification of the security finding.
    finding_type: []const u8,

    /// The name of the product associated with the security finding.
    product_name: []const u8,

    /// A breakdown of security findings by their severity levels.
    severities: ?ResourceSeverityBreakdown = null,

    /// The total count of security findings.
    total_findings: i32,

    pub const json_field_names = .{
        .finding_type = "FindingType",
        .product_name = "ProductName",
        .severities = "Severities",
        .total_findings = "TotalFindings",
    };
};
