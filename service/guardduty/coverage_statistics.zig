const aws = @import("aws");

/// Information about the coverage statistics for a resource.
pub const CoverageStatistics = struct {
    /// Represents coverage statistics for EKS clusters aggregated by coverage
    /// status.
    count_by_coverage_status: ?[]const aws.map.MapEntry(i64) = null,

    /// Represents coverage statistics for EKS clusters aggregated by resource type.
    count_by_resource_type: ?[]const aws.map.MapEntry(i64) = null,

    pub const json_field_names = .{
        .count_by_coverage_status = "CountByCoverageStatus",
        .count_by_resource_type = "CountByResourceType",
    };
};
