const FargateProfileIssueCode = @import("fargate_profile_issue_code.zig").FargateProfileIssueCode;

/// An issue that is associated with the Fargate profile.
pub const FargateProfileIssue = struct {
    /// A brief description of the error.
    code: ?FargateProfileIssueCode = null,

    /// The error message associated with the issue.
    message: ?[]const u8 = null,

    /// The Amazon Web Services resources that are affected by this issue.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .resource_ids = "resourceIds",
    };
};
