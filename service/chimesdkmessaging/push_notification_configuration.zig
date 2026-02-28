const PushNotificationType = @import("push_notification_type.zig").PushNotificationType;

/// The push notification configuration of the message.
pub const PushNotificationConfiguration = struct {
    /// The body of the push notification.
    body: ?[]const u8,

    /// The title of the push notification.
    title: ?[]const u8,

    /// Enum value that indicates the type of the push notification for a message.
    /// `DEFAULT`: Normal mobile push notification.
    /// `VOIP`: VOIP mobile push notification.
    @"type": ?PushNotificationType,

    pub const json_field_names = .{
        .body = "Body",
        .title = "Title",
        .@"type" = "Type",
    };
};
