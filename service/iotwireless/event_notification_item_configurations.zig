const ConnectionStatusEventConfiguration = @import("connection_status_event_configuration.zig").ConnectionStatusEventConfiguration;
const DeviceRegistrationStateEventConfiguration = @import("device_registration_state_event_configuration.zig").DeviceRegistrationStateEventConfiguration;
const JoinEventConfiguration = @import("join_event_configuration.zig").JoinEventConfiguration;
const MessageDeliveryStatusEventConfiguration = @import("message_delivery_status_event_configuration.zig").MessageDeliveryStatusEventConfiguration;
const ProximityEventConfiguration = @import("proximity_event_configuration.zig").ProximityEventConfiguration;

/// Object of all event configurations and the status of the event topics.
pub const EventNotificationItemConfigurations = struct {
    /// Connection status event configuration for an event configuration item.
    connection_status: ?ConnectionStatusEventConfiguration,

    /// Device registration state event configuration for an event configuration
    /// item.
    device_registration_state: ?DeviceRegistrationStateEventConfiguration,

    /// Join event configuration for an event configuration item.
    join: ?JoinEventConfiguration,

    /// Message delivery status event configuration for an event configuration item.
    message_delivery_status: ?MessageDeliveryStatusEventConfiguration,

    /// Proximity event configuration for an event configuration item.
    proximity: ?ProximityEventConfiguration,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .device_registration_state = "DeviceRegistrationState",
        .join = "Join",
        .message_delivery_status = "MessageDeliveryStatus",
        .proximity = "Proximity",
    };
};
