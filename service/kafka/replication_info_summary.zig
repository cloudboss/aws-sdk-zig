/// Summarized information of replication between clusters.
pub const ReplicationInfoSummary = struct {
    /// The alias of the source Kafka cluster.
    source_kafka_cluster_alias: ?[]const u8 = null,

    /// The alias of the target Kafka cluster.
    target_kafka_cluster_alias: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_kafka_cluster_alias = "SourceKafkaClusterAlias",
        .target_kafka_cluster_alias = "TargetKafkaClusterAlias",
    };
};
