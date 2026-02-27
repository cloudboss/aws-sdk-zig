const Category = @import("category.zig").Category;
const InsightStatus = @import("insight_status.zig").InsightStatus;

/// The summarized description of the insight.
pub const InsightSummary = struct {
    /// The category of the insight.
    category: ?Category,

    /// The description of the insight which includes alert criteria, remediation
    /// recommendation, and additional resources (contains Markdown).
    description: ?[]const u8,

    /// The ID of the insight.
    id: ?[]const u8,

    /// An object containing more detail on the status of the insight.
    insight_status: ?InsightStatus,

    /// The Kubernetes minor version associated with an insight if applicable.
    kubernetes_version: ?[]const u8,

    /// The time Amazon EKS last successfully completed a refresh of this insight
    /// check on the
    /// cluster.
    last_refresh_time: ?i64,

    /// The time the status of the insight last changed.
    last_transition_time: ?i64,

    /// The name of the insight.
    name: ?[]const u8,

    pub const json_field_names = .{
        .category = "category",
        .description = "description",
        .id = "id",
        .insight_status = "insightStatus",
        .kubernetes_version = "kubernetesVersion",
        .last_refresh_time = "lastRefreshTime",
        .last_transition_time = "lastTransitionTime",
        .name = "name",
    };
};
