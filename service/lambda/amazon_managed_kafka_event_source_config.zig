const KafkaSchemaRegistryConfig = @import("kafka_schema_registry_config.zig").KafkaSchemaRegistryConfig;

/// Specific configuration settings for an Amazon Managed Streaming for Apache
/// Kafka (Amazon MSK) event source.
pub const AmazonManagedKafkaEventSourceConfig = struct {
    /// The identifier for the Kafka consumer group to join. The consumer group ID
    /// must be unique among all your Kafka event sources. After creating a Kafka
    /// event source mapping with the consumer group ID specified, you cannot update
    /// this value. For more information, see [Customizable consumer group
    /// ID](https://docs.aws.amazon.com/lambda/latest/dg/with-msk.html#services-msk-consumer-group-id).
    consumer_group_id: ?[]const u8,

    /// Specific configuration settings for a Kafka schema registry.
    schema_registry_config: ?KafkaSchemaRegistryConfig,
};
