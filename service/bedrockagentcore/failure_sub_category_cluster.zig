const RootCauseCluster = @import("root_cause_cluster.zig").RootCauseCluster;

/// A subcategory of failures within a top-level failure category.
pub const FailureSubCategoryCluster = struct {
    /// The number of sessions affected by this failure subcategory.
    affected_session_count: i32,

    /// The unique identifier of the failure subcategory cluster.
    cluster_id: i32,

    /// A description of the failure subcategory pattern.
    description: []const u8,

    /// The name of the failure subcategory.
    name: []const u8,

    /// The list of root cause clusters identified within this subcategory.
    root_causes: []const RootCauseCluster,

    pub const json_field_names = .{
        .affected_session_count = "affectedSessionCount",
        .cluster_id = "clusterId",
        .description = "description",
        .name = "name",
        .root_causes = "rootCauses",
    };
};
