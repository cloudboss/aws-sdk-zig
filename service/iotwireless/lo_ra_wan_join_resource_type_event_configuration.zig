const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Object for LoRaWAN join resource type event configuration.
pub const LoRaWANJoinResourceTypeEventConfiguration = struct {
    /// Denotes whether the wireless device join event topic is enabled or disabled.
    wireless_device_event_topic: ?EventNotificationTopicStatus = null,

    pub const json_field_names = .{
        .wireless_device_event_topic = "WirelessDeviceEventTopic",
    };
};
