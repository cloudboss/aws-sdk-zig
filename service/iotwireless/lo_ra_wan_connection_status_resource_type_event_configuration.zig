const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Object for LoRaWAN connection status resource type event configuration.
pub const LoRaWANConnectionStatusResourceTypeEventConfiguration = struct {
    /// Denotes whether the wireless gateway connection status event topic is
    /// enabled or
    /// disabled.
    wireless_gateway_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .wireless_gateway_event_topic = "WirelessGatewayEventTopic",
    };
};
