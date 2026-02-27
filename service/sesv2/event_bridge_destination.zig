/// An object that defines an Amazon EventBridge destination for email events.
/// You can use Amazon EventBridge to
/// send notifications when certain email events occur.
pub const EventBridgeDestination = struct {
    /// The Amazon Resource Name (ARN) of the Amazon EventBridge bus to publish
    /// email events to. Only the default bus is supported.
    event_bus_arn: []const u8,

    pub const json_field_names = .{
        .event_bus_arn = "EventBusArn",
    };
};
