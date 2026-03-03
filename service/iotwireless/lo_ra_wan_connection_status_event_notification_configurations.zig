const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Object for LoRaWAN connection status resource type event configuration.
pub const LoRaWANConnectionStatusEventNotificationConfigurations = struct {
    /// Denotes whether the gateway EUI connection status event topic is enabled or
    /// disabled.
    gateway_eui_event_topic: ?EventNotificationTopicStatus = null,

    pub const json_field_names = .{
        .gateway_eui_event_topic = "GatewayEuiEventTopic",
    };
};
