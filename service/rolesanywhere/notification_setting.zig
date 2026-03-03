const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const NotificationEvent = @import("notification_event.zig").NotificationEvent;

/// Customizable notification settings that will be applied to notification
/// events. IAM Roles Anywhere consumes these settings while notifying across
/// multiple channels - CloudWatch metrics, EventBridge, and Health Dashboard.
pub const NotificationSetting = struct {
    /// The specified channel of notification. IAM Roles Anywhere uses CloudWatch
    /// metrics, EventBridge, and Health Dashboard to notify for an event.
    ///
    /// In the absence of a specific channel, IAM Roles Anywhere applies this
    /// setting to 'ALL' channels.
    channel: ?NotificationChannel = null,

    /// Indicates whether the notification setting is enabled.
    enabled: bool,

    /// The event to which this notification setting is applied.
    event: NotificationEvent,

    /// The number of days before a notification event. This value is required for a
    /// notification setting that is enabled.
    threshold: ?i32 = null,

    pub const json_field_names = .{
        .channel = "channel",
        .enabled = "enabled",
        .event = "event",
        .threshold = "threshold",
    };
};
