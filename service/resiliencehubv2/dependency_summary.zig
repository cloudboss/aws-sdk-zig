const DependencyCriticality = @import("dependency_criticality.zig").DependencyCriticality;
const QueryRange = @import("query_range.zig").QueryRange;

/// Contains summary information about a discovered dependency.
pub const DependencySummary = struct {
    /// A user-provided comment about the dependency.
    comment: ?[]const u8 = null,

    /// The criticality level of the dependency.
    criticality: DependencyCriticality,

    /// The unique identifier of the dependency.
    dependency_id: []const u8,

    /// The name of the dependency.
    dependency_name: []const u8,

    /// The DNS name associated with the dependency.
    dns_name: []const u8,

    /// The timestamp when the dependency was last detected.
    last_detected_time: i64,

    /// The location of the dependency.
    location: []const u8,

    /// The provider of the dependency.
    provider: ?[]const u8 = null,

    /// The query range data for the dependency.
    query_range: QueryRange,

    service_arn: []const u8,

    /// The source Regions from which the dependency was detected.
    source_regions: []const []const u8,

    pub const json_field_names = .{
        .comment = "comment",
        .criticality = "criticality",
        .dependency_id = "dependencyId",
        .dependency_name = "dependencyName",
        .dns_name = "dnsName",
        .last_detected_time = "lastDetectedTime",
        .location = "location",
        .provider = "provider",
        .query_range = "queryRange",
        .service_arn = "serviceArn",
        .source_regions = "sourceRegions",
    };
};
