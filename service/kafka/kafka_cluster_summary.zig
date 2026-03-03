const AmazonMskCluster = @import("amazon_msk_cluster.zig").AmazonMskCluster;

/// Summarized information about Kafka Cluster used as source / target for
/// replication.
pub const KafkaClusterSummary = struct {
    /// Details of an Amazon MSK Cluster.
    amazon_msk_cluster: ?AmazonMskCluster = null,

    /// The alias of the Kafka cluster. Used to prefix names of replicated topics.
    kafka_cluster_alias: ?[]const u8 = null,

    pub const json_field_names = .{
        .amazon_msk_cluster = "AmazonMskCluster",
        .kafka_cluster_alias = "KafkaClusterAlias",
    };
};
