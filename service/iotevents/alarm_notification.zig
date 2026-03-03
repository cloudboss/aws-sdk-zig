const NotificationAction = @import("notification_action.zig").NotificationAction;

/// Contains information about one or more notification actions.
pub const AlarmNotification = struct {
    /// Contains the notification settings of an alarm model.
    /// The settings apply to all alarms that were created based on this alarm
    /// model.
    notification_actions: ?[]const NotificationAction = null,

    pub const json_field_names = .{
        .notification_actions = "notificationActions",
    };
};
