const ConsumerGroupReplication = @import("consumer_group_replication.zig").ConsumerGroupReplication;
const TargetCompressionType = @import("target_compression_type.zig").TargetCompressionType;
const TopicReplication = @import("topic_replication.zig").TopicReplication;

/// Specifies configuration for replication between a source and target Kafka
/// cluster (sourceKafkaClusterAlias -> targetKafkaClusterAlias)
pub const ReplicationInfoDescription = struct {
    /// Configuration relating to consumer group replication.
    consumer_group_replication: ?ConsumerGroupReplication = null,

    /// The alias of the source Kafka cluster.
    source_kafka_cluster_alias: ?[]const u8 = null,

    /// The compression type to use when producing records to target cluster.
    target_compression_type: ?TargetCompressionType = null,

    /// The alias of the target Kafka cluster.
    target_kafka_cluster_alias: ?[]const u8 = null,

    /// Configuration relating to topic replication.
    topic_replication: ?TopicReplication = null,

    pub const json_field_names = .{
        .consumer_group_replication = "ConsumerGroupReplication",
        .source_kafka_cluster_alias = "SourceKafkaClusterAlias",
        .target_compression_type = "TargetCompressionType",
        .target_kafka_cluster_alias = "TargetKafkaClusterAlias",
        .topic_replication = "TopicReplication",
    };
};
