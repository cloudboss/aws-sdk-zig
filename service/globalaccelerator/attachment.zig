const Resource = @import("resource.zig").Resource;

/// A cross-account attachment in Global Accelerator. A cross-account attachment
/// specifies the *principals* who have permission to work with *resources*
/// in your account, which you also list in the attachment.
pub const Attachment = struct {
    /// The Amazon Resource Name (ARN) of the cross-account attachment.
    attachment_arn: ?[]const u8 = null,

    /// The date and time that the cross-account attachment was created.
    created_time: ?i64 = null,

    /// The date and time that the cross-account attachment was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the cross-account attachment.
    name: ?[]const u8 = null,

    /// The principals included in the cross-account attachment.
    principals: ?[]const []const u8 = null,

    /// The resources included in the cross-account attachment.
    resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .attachment_arn = "AttachmentArn",
        .created_time = "CreatedTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .principals = "Principals",
        .resources = "Resources",
    };
};
