const aws = @import("aws");

const Category = @import("category.zig").Category;
const InsightCategorySpecificSummary = @import("insight_category_specific_summary.zig").InsightCategorySpecificSummary;
const InsightStatus = @import("insight_status.zig").InsightStatus;
const InsightResourceDetail = @import("insight_resource_detail.zig").InsightResourceDetail;

/// A check that provides recommendations to remedy potential upgrade-impacting
/// issues.
pub const Insight = struct {
    /// Links to sources that provide additional context on the insight.
    additional_info: ?[]const aws.map.StringMapEntry,

    /// The category of the insight.
    category: ?Category,

    /// Summary information that relates to the category of the insight. Currently
    /// only
    /// returned with certain insights having category `UPGRADE_READINESS`.
    category_specific_summary: ?InsightCategorySpecificSummary,

    /// The description of the insight which includes alert criteria, remediation
    /// recommendation, and additional resources (contains Markdown).
    description: ?[]const u8,

    /// The ID of the insight.
    id: ?[]const u8,

    /// An object containing more detail on the status of the insight resource.
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

    /// A summary of how to remediate the finding of this insight if applicable.
    recommendation: ?[]const u8,

    /// The details about each resource listed in the insight check result.
    resources: ?[]const InsightResourceDetail,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .category = "category",
        .category_specific_summary = "categorySpecificSummary",
        .description = "description",
        .id = "id",
        .insight_status = "insightStatus",
        .kubernetes_version = "kubernetesVersion",
        .last_refresh_time = "lastRefreshTime",
        .last_transition_time = "lastTransitionTime",
        .name = "name",
        .recommendation = "recommendation",
        .resources = "resources",
    };
};
