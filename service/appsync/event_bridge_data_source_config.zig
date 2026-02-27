/// Describes an Amazon EventBridge bus data source configuration.
pub const EventBridgeDataSourceConfig = struct {
    /// The ARN of the event bus. For more information about event buses, see
    /// [Amazon
    /// EventBridge event
    /// buses](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-event-bus.html).
    event_bus_arn: []const u8,

    pub const json_field_names = .{
        .event_bus_arn = "eventBusArn",
    };
};
