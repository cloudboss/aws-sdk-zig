const LoRaWANJoinEventNotificationConfigurations = @import("lo_ra_wan_join_event_notification_configurations.zig").LoRaWANJoinEventNotificationConfigurations;
const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Join event configuration object for enabling or disabling topic.
pub const JoinEventConfiguration = struct {
    /// Join event configuration object for enabling or disabling LoRaWAN related
    /// event
    /// topics.
    lo_ra_wan: ?LoRaWANJoinEventNotificationConfigurations,

    /// Denotes whether the wireless device ID join event topic is enabled or
    /// disabled.
    wireless_device_id_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .wireless_device_id_event_topic = "WirelessDeviceIdEventTopic",
    };
};
