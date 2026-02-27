const SidewalkEventNotificationConfigurations = @import("sidewalk_event_notification_configurations.zig").SidewalkEventNotificationConfigurations;
const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Message delivery status event configuration object for enabling and
/// disabling relevant
/// topics.
pub const MessageDeliveryStatusEventConfiguration = struct {
    sidewalk: ?SidewalkEventNotificationConfigurations,

    /// Denotes whether the wireless device ID message delivery status event topic
    /// is enabled
    /// or disabled.
    wireless_device_id_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
        .wireless_device_id_event_topic = "WirelessDeviceIdEventTopic",
    };
};
