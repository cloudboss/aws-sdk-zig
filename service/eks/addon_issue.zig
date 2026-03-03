const AddonIssueCode = @import("addon_issue_code.zig").AddonIssueCode;

/// An issue related to an add-on.
pub const AddonIssue = struct {
    /// A code that describes the type of issue.
    code: ?AddonIssueCode = null,

    /// A message that provides details about the issue and what might cause it.
    message: ?[]const u8 = null,

    /// The resource IDs of the issue.
    resource_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .resource_ids = "resourceIds",
    };
};
