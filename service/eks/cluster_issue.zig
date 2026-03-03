const ClusterIssueCode = @import("cluster_issue_code.zig").ClusterIssueCode;

/// An issue with your Amazon EKS cluster.
pub const ClusterIssue = struct {
    /// The error code of the issue.
    code: ?ClusterIssueCode = null,

    /// A description of the issue.
    message: ?[]const u8 = null,

    /// The resource IDs that the issue relates to.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .resource_ids = "resourceIds",
    };
};
