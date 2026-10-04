const FailureSubCategoryCluster = @import("failure_sub_category_cluster.zig").FailureSubCategoryCluster;

/// A top-level failure category identified by clustering similar failure
/// patterns across sessions.
pub const FailureCategoryCluster = struct {
    /// The number of sessions affected by this failure category.
    affected_session_count: i32,

    /// The unique identifier of the failure category cluster.
    cluster_id: i32,

    /// A description of the failure category pattern.
    description: []const u8,

    /// The name of the failure category.
    name: []const u8,

    /// The list of failure subcategories within this category.
    sub_categories: []const FailureSubCategoryCluster,

    pub const json_field_names = .{
        .affected_session_count = "affectedSessionCount",
        .cluster_id = "clusterId",
        .description = "description",
        .name = "name",
        .sub_categories = "subCategories",
    };
};
