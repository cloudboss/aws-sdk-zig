const EventBridgeConfiguration = @import("event_bridge_configuration.zig").EventBridgeConfiguration;

/// Notification configuration.
pub const NotificationConfiguration = struct {
    /// Event bridge configuration.
    event_bridge_configuration: EventBridgeConfiguration,

    pub const json_field_names = .{
        .event_bridge_configuration = "eventBridgeConfiguration",
    };
};
