const LoRaWANConnectionStatusEventNotificationConfigurations = @import("lo_ra_wan_connection_status_event_notification_configurations.zig").LoRaWANConnectionStatusEventNotificationConfigurations;
const EventNotificationTopicStatus = @import("event_notification_topic_status.zig").EventNotificationTopicStatus;

/// Connection status event configuration object for enabling or disabling
/// topic.
pub const ConnectionStatusEventConfiguration = struct {
    /// Connection status event configuration object for enabling or disabling
    /// LoRaWAN related
    /// event topics.
    lo_ra_wan: ?LoRaWANConnectionStatusEventNotificationConfigurations,

    /// Denotes whether the wireless gateway ID connection status event topic is
    /// enabled or
    /// disabled.
    wireless_gateway_id_event_topic: ?EventNotificationTopicStatus,

    pub const json_field_names = .{
        .lo_ra_wan = "LoRaWAN",
        .wireless_gateway_id_event_topic = "WirelessGatewayIdEventTopic",
    };
};
