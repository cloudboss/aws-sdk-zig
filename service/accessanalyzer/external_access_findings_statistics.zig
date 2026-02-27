const aws = @import("aws");

const ResourceTypeDetails = @import("resource_type_details.zig").ResourceTypeDetails;

/// Provides aggregate statistics about the findings for the specified external
/// access analyzer.
pub const ExternalAccessFindingsStatistics = struct {
    /// The total number of active cross-account and public findings for each
    /// resource type of the specified external access analyzer.
    resource_type_statistics: ?[]const aws.map.MapEntry(ResourceTypeDetails),

    /// The number of active findings for the specified external access analyzer.
    total_active_findings: ?i32,

    /// The number of archived findings for the specified external access analyzer.
    total_archived_findings: ?i32,

    /// The number of resolved findings for the specified external access analyzer.
    total_resolved_findings: ?i32,

    pub const json_field_names = .{
        .resource_type_statistics = "resourceTypeStatistics",
        .total_active_findings = "totalActiveFindings",
        .total_archived_findings = "totalArchivedFindings",
        .total_resolved_findings = "totalResolvedFindings",
    };
};
