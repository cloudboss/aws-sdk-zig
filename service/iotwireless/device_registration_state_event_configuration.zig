const SidewalkEventNotificationConfigurations = @import("sidewalk_event_notification_configurations.zig").SidewalkEventNotificationConfigurations;
const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Device registration state event configuration object for enabling and
/// disabling
/// relevant topics.
pub const DeviceRegistrationStateEventConfiguration = struct {
    /// Device registration state event configuration object for enabling or
    /// disabling
    /// Sidewalk related event topics.
    sidewalk: ?SidewalkEventNotificationConfigurations,

    /// Denotes whether the wireless device ID device registration state event topic
    /// is
    /// enabled or disabled.
    wireless_device_id_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .sidewalk = "Sidewalk",
        .wireless_device_id_event_topic = "WirelessDeviceIdEventTopic",
    };
};
