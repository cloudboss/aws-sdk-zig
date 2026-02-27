const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const NotificationEvent = @import("notification_event.zig").NotificationEvent;

/// The state of a notification setting.
///
/// A notification setting includes information such as event name, threshold,
/// status of the notification setting, and the channel to notify.
pub const NotificationSettingDetail = struct {
    /// The specified channel of notification. IAM Roles Anywhere uses CloudWatch
    /// metrics, EventBridge, and Health Dashboard to notify for an event.
    ///
    /// In the absence of a specific channel, IAM Roles Anywhere applies this
    /// setting to 'ALL' channels.
    channel: ?NotificationChannel,

    /// The principal that configured the notification setting. For default settings
    /// configured by IAM Roles Anywhere, the value is
    /// `rolesanywhere.amazonaws.com`, and for customized notifications settings, it
    /// is the respective account ID.
    configured_by: ?[]const u8,

    /// Indicates whether the notification setting is enabled.
    enabled: bool,

    /// The event to which this notification setting is applied.
    event: NotificationEvent,

    /// The number of days before a notification event.
    threshold: ?i32,

    pub const json_field_names = .{
        .channel = "channel",
        .configured_by = "configuredBy",
        .enabled = "enabled",
        .event = "event",
        .threshold = "threshold",
    };
};
