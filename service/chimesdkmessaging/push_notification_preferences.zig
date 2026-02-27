const AllowNotifications = @import("allow_notifications.zig").AllowNotifications;

/// The channel membership preferences for push notification.
pub const PushNotificationPreferences = struct {
    /// Enum value that indicates which push notifications to send to the requested
    /// member of a channel.
    /// `ALL` sends all push notifications, `NONE` sends no push notifications,
    /// `FILTERED` sends only filtered push notifications.
    allow_notifications: AllowNotifications,

    /// The simple JSON object used to send a subset of a push notification to the
    /// requested member.
    filter_rule: ?[]const u8,

    pub const json_field_names = .{
        .allow_notifications = "AllowNotifications",
        .filter_rule = "FilterRule",
    };
};
