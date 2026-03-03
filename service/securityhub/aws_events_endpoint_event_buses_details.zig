/// Provides details about the Amazon EventBridge event buses that the endpoint
/// is associated with.
pub const AwsEventsEndpointEventBusesDetails = struct {
    /// The Amazon Resource Name (ARN) of the event bus that the endpoint is
    /// associated with.
    event_bus_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_bus_arn = "EventBusArn",
    };
};
