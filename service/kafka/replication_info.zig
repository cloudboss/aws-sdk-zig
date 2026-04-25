const ConsumerGroupReplication = @import("consumer_group_replication.zig").ConsumerGroupReplication;
const TargetCompressionType = @import("target_compression_type.zig").TargetCompressionType;
const TopicReplication = @import("topic_replication.zig").TopicReplication;

/// Specifies configuration for replication between a source and target Kafka
/// cluster.
pub const ReplicationInfo = struct {
    /// Configuration relating to consumer group replication.
    consumer_group_replication: ConsumerGroupReplication,

    /// The ARN of the source Kafka cluster.
    source_kafka_cluster_arn: ?[]const u8 = null,

    /// The ID of the source Kafka cluster.
    source_kafka_cluster_id: ?[]const u8 = null,

    /// The compression type to use when producing records to target cluster.
    target_compression_type: TargetCompressionType,

    /// The ARN of the target Kafka cluster.
    target_kafka_cluster_arn: ?[]const u8 = null,

    /// The ID of the target Kafka cluster.
    target_kafka_cluster_id: ?[]const u8 = null,

    /// Configuration relating to topic replication.
    topic_replication: TopicReplication,

    pub const json_field_names = .{
        .consumer_group_replication = "ConsumerGroupReplication",
        .source_kafka_cluster_arn = "SourceKafkaClusterArn",
        .source_kafka_cluster_id = "SourceKafkaClusterId",
        .target_compression_type = "TargetCompressionType",
        .target_kafka_cluster_arn = "TargetKafkaClusterArn",
        .target_kafka_cluster_id = "TargetKafkaClusterId",
        .topic_replication = "TopicReplication",
    };
};
