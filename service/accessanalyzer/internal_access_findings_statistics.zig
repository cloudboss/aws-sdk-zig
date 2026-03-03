const aws = @import("aws");

const InternalAccessResourceTypeDetails = @import("internal_access_resource_type_details.zig").InternalAccessResourceTypeDetails;

/// Provides aggregate statistics about the findings for the specified internal
/// access analyzer. This includes counts of active, archived, and resolved
/// findings.
pub const InternalAccessFindingsStatistics = struct {
    /// The total number of active findings for each resource type of the specified
    /// internal access analyzer.
    resource_type_statistics: ?[]const aws.map.MapEntry(InternalAccessResourceTypeDetails) = null,

    /// The number of active findings for the specified internal access analyzer.
    total_active_findings: ?i32 = null,

    /// The number of archived findings for the specified internal access analyzer.
    total_archived_findings: ?i32 = null,

    /// The number of resolved findings for the specified internal access analyzer.
    total_resolved_findings: ?i32 = null,

    pub const json_field_names = .{
        .resource_type_statistics = "resourceTypeStatistics",
        .total_active_findings = "totalActiveFindings",
        .total_archived_findings = "totalArchivedFindings",
        .total_resolved_findings = "totalResolvedFindings",
    };
};
