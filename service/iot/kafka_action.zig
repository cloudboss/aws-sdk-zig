const aws = @import("aws");

const KafkaActionHeader = @import("kafka_action_header.zig").KafkaActionHeader;

/// Send messages to an Amazon Managed Streaming for Apache Kafka (Amazon MSK)
/// or self-managed Apache Kafka cluster.
pub const KafkaAction = struct {
    /// Properties of the Apache Kafka producer client.
    client_properties: []const aws.map.StringMapEntry,

    /// The ARN of Kafka action's VPC `TopicRuleDestination`.
    destination_arn: []const u8,

    /// The list of Kafka headers that you specify.
    headers: ?[]const KafkaActionHeader = null,

    /// The Kafka message key.
    key: ?[]const u8 = null,

    /// The Kafka message partition.
    partition: ?[]const u8 = null,

    /// The Kafka topic for messages to be sent to the Kafka broker.
    topic: []const u8,

    pub const json_field_names = .{
        .client_properties = "clientProperties",
        .destination_arn = "destinationArn",
        .headers = "headers",
        .key = "key",
        .partition = "partition",
        .topic = "topic",
    };
};
