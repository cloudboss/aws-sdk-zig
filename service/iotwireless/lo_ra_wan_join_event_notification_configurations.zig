const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Object for LoRaWAN join resource type event configuration.
pub const LoRaWANJoinEventNotificationConfigurations = struct {
    /// Denotes whether the Dev EUI join event topic is enabled or disabled.
    dev_eui_event_topic: ?EventNotificationTopicStatus = null,

    pub const json_field_names = .{
        .dev_eui_event_topic = "DevEuiEventTopic",
    };
};
