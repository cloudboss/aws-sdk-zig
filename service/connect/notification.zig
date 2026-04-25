const aws = @import("aws");

const NotificationPriority = @import("notification_priority.zig").NotificationPriority;

/// Contains information about a notification, including its content, priority,
/// recipients, and metadata.
pub const Notification = struct {
    /// The Amazon Resource Name (ARN) of the notification.
    arn: []const u8,

    /// The localized content of the notification. A map where keys are locale codes
    /// and values are the notification text in that locale.
    content: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the notification was created.
    created_at: ?i64 = null,

    /// The timestamp when the notification expires and is no longer displayed to
    /// users.
    expires_at: ?i64 = null,

    /// The unique identifier for the notification.
    id: []const u8,

    /// The AWS Region where the notification was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when the notification was last modified.
    last_modified_time: i64,

    /// The priority level of the notification. Valid values are URGENT, HIGH, and
    /// LOW.
    priority: ?NotificationPriority = null,

    /// A list of Amazon Resource Names (ARNs) identifying the recipients of the
    /// notification. Maximum of 200 recipients.
    recipients: ?[]const []const u8 = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, `{ "Tags": {"key1":"value1", "key2":"value2"} }`.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .priority = "Priority",
        .recipients = "Recipients",
        .tags = "Tags",
    };
};
