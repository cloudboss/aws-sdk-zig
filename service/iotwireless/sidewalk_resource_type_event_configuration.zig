const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Sidewalk resource type event configuration object for enabling or disabling
/// topic.
pub const SidewalkResourceTypeEventConfiguration = struct {
    /// Denotes whether the wireless device join event topic is enabled or disabled.
    wireless_device_event_topic: ?EventNotificationTopicStatus = null,

    pub const json_field_names = .{
        .wireless_device_event_topic = "WirelessDeviceEventTopic",
    };
};
