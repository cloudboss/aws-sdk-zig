const LambdaEventSourceType = @import("lambda_event_source_type.zig").LambdaEventSourceType;

/// Contains information about an event source for an Lambda function. The event
/// source
/// defines the topics on which this Lambda function subscribes to receive
/// messages that run the
/// function.
pub const LambdaEventSource = struct {
    /// The topic to which to subscribe to receive event messages.
    topic: []const u8,

    /// The type of event source. Choose from the following options:
    ///
    /// * `PUB_SUB` – Subscribe to local publish/subscribe messages. This
    /// event source type doesn't support MQTT wildcards (`+` and `#`) in
    /// the event source topic.
    ///
    /// * `IOT_CORE` – Subscribe to Amazon Web Services IoT Core MQTT messages. This
    ///   event source
    /// type supports MQTT wildcards (`+` and `#`) in the event source
    /// topic.
    type: LambdaEventSourceType,

    pub const json_field_names = .{
        .topic = "topic",
        .type = "type",
    };
};
