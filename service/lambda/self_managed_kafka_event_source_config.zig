const KafkaSchemaRegistryConfig = @import("kafka_schema_registry_config.zig").KafkaSchemaRegistryConfig;

/// Specific configuration settings for a self-managed Apache Kafka event
/// source.
pub const SelfManagedKafkaEventSourceConfig = struct {
    /// The identifier for the Kafka consumer group to join. The consumer group ID
    /// must be unique among all your Kafka event sources. After creating a Kafka
    /// event source mapping with the consumer group ID specified, you cannot update
    /// this value. For more information, see [Customizable consumer group
    /// ID](https://docs.aws.amazon.com/lambda/latest/dg/with-kafka-process.html#services-smaa-topic-add).
    consumer_group_id: ?[]const u8 = null,

    /// Specific configuration settings for a Kafka schema registry.
    schema_registry_config: ?KafkaSchemaRegistryConfig = null,

    pub const json_field_names = .{
        .consumer_group_id = "ConsumerGroupId",
        .schema_registry_config = "SchemaRegistryConfig",
    };
};
