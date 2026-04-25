const aws = @import("aws");

const NotificationPriority = @import("notification_priority.zig").NotificationPriority;

/// Summary information about a notification returned from a search operation.
pub const NotificationSearchSummary = struct {
    /// The Amazon Resource Name (ARN) of the notification.
    arn: ?[]const u8 = null,

    /// The localized content of the notification.
    content: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the notification was created.
    created_at: ?i64 = null,

    /// The timestamp when the notification expires.
    expires_at: ?i64 = null,

    /// The unique identifier for the notification.
    id: ?[]const u8 = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: ?[]const u8 = null,

    /// The AWS Region where the notification was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the notification was last modified.
    last_modified_time: ?i64 = null,

    /// The priority level of the notification.
    priority: ?NotificationPriority = null,

    /// A list of recipient Amazon Resource Names (ARNs).
    recipients: ?[]const []const u8 = null,

    /// The tags associated with the notification.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .instance_id = "InstanceId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .priority = "Priority",
        .recipients = "Recipients",
        .tags = "Tags",
    };
};
