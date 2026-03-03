const PushNotificationPreferences = @import("push_notification_preferences.zig").PushNotificationPreferences;

/// The channel membership preferences for an `AppInstanceUser`.
pub const ChannelMembershipPreferences = struct {
    /// The push notification configuration of a message.
    push_notifications: ?PushNotificationPreferences = null,

    pub const json_field_names = .{
        .push_notifications = "PushNotifications",
    };
};
