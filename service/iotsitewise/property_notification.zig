const PropertyNotificationState = @import("property_notification_state.zig").PropertyNotificationState;

/// Contains asset property value notification information. When the
/// notification state is enabled, IoT SiteWise publishes property value
/// updates to a unique MQTT topic. For more information, see [Interacting with
/// other
/// services](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/interact-with-other-services.html) in the *IoT SiteWise User Guide*.
pub const PropertyNotification = struct {
    /// The current notification state.
    state: PropertyNotificationState,

    /// The MQTT topic to which IoT SiteWise publishes property value update
    /// notifications.
    topic: []const u8,

    pub const json_field_names = .{
        .state = "state",
        .topic = "topic",
    };
};
