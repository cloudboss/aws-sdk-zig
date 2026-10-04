const FailureCategoryCluster = @import("failure_category_cluster.zig").FailureCategoryCluster;

/// The failure analysis clustering result containing categorized failure
/// clusters with root causes and remediation recommendations.
pub const FailureAnalysisResultContent = struct {
    /// The list of failure category clusters identified across analyzed sessions.
    failures: []const FailureCategoryCluster,

    pub const json_field_names = .{
        .failures = "failures",
    };
};
