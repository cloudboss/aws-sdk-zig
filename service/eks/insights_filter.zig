const Category = @import("category.zig").Category;
const InsightStatusValue = @import("insight_status_value.zig").InsightStatusValue;

/// The criteria to use for the insights.
pub const InsightsFilter = struct {
    /// The categories to use to filter insights. The following lists the available
    /// categories:
    ///
    /// * `UPGRADE_READINESS`: Amazon EKS identifies issues that could impact your
    /// ability to upgrade to new versions of Kubernetes. These are called upgrade
    /// insights.
    ///
    /// * `MISCONFIGURATION`: Amazon EKS identifies misconfiguration in your EKS
    /// Hybrid Nodes setup that could impair functionality of your cluster or
    /// workloads. These are called configuration insights.
    categories: ?[]const Category,

    /// The Kubernetes versions to use to filter the insights.
    kubernetes_versions: ?[]const []const u8,

    /// The statuses to use to filter the insights.
    statuses: ?[]const InsightStatusValue,

    pub const json_field_names = .{
        .categories = "categories",
        .kubernetes_versions = "kubernetesVersions",
        .statuses = "statuses",
    };
};
