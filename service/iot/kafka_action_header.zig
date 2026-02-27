/// Specifies a Kafka header using key-value pairs when you create a Rule’s
/// Kafka Action.
/// You can use these headers to route data from IoT clients to downstream Kafka
/// clusters
/// without modifying your message payload.
///
/// For more information about Rule's Kafka action, see [Apache
/// Kafka](https://docs.aws.amazon.com/iot/latest/developerguide/apache-kafka-rule-action.html).
pub const KafkaActionHeader = struct {
    /// The key of the Kafka header.
    key: []const u8,

    /// The value of the Kafka header.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
