/// The event buses the endpoint is associated with.
pub const EndpointEventBus = struct {
    /// The ARN of the event bus the endpoint is associated with.
    event_bus_arn: []const u8,

    pub const json_field_names = .{
        .event_bus_arn = "EventBusArn",
    };
};
