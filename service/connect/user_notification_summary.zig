const aws = @import("aws");

const NotificationStatus = @import("notification_status.zig").NotificationStatus;
const NotificationPriority = @import("notification_priority.zig").NotificationPriority;
const NotificationSource = @import("notification_source.zig").NotificationSource;

/// Summary information about a notification for a specific user, including the
/// user's read status.
pub const UserNotificationSummary = struct {
    /// The localized content of the notification.
    content: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the notification was created.
    created_at: ?i64 = null,

    /// The timestamp when the notification expires.
    expires_at: ?i64 = null,

    /// The identifier of the Amazon Connect instance.
    instance_id: ?[]const u8 = null,

    /// The unique identifier for the notification.
    notification_id: ?[]const u8 = null,

    /// The status of the notification for this user. Valid values are READ, UNREAD,
    /// and HIDDEN.
    notification_status: ?NotificationStatus = null,

    /// The priority level of the notification.
    priority: ?NotificationPriority = null,

    /// The identifier of the recipient user.
    recipient_id: ?[]const u8 = null,

    /// The source that created the notification. Valid values are CUSTOMER, RULES,
    /// and SYSTEM.
    source: ?NotificationSource = null,

    pub const json_field_names = .{
        .content = "Content",
        .created_at = "CreatedAt",
        .expires_at = "ExpiresAt",
        .instance_id = "InstanceId",
        .notification_id = "NotificationId",
        .notification_status = "NotificationStatus",
        .priority = "Priority",
        .recipient_id = "RecipientId",
        .source = "Source",
    };
};
