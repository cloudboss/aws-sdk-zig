const ClusterIssue = @import("cluster_issue.zig").ClusterIssue;

/// An object representing the health of your Amazon EKS cluster.
pub const ClusterHealth = struct {
    /// An object representing the health issues of your Amazon EKS cluster.
    issues: ?[]const ClusterIssue = null,

    pub const json_field_names = .{
        .issues = "issues",
    };
};
