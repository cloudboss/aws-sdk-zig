const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const NotificationEvent = @import("notification_event.zig").NotificationEvent;

/// A notification setting key to reset. A notification setting key includes the
/// event and the channel.
pub const NotificationSettingKey = struct {
    /// The specified channel of notification.
    channel: ?NotificationChannel,

    /// The notification setting event to reset.
    event: NotificationEvent,

    pub const json_field_names = .{
        .channel = "channel",
        .event = "event",
    };
};
