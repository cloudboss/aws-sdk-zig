const AmazonMskCluster = @import("amazon_msk_cluster.zig").AmazonMskCluster;
const ApacheKafkaCluster = @import("apache_kafka_cluster.zig").ApacheKafkaCluster;

/// Summarized information about Kafka Cluster used as source / target for
/// replication.
pub const KafkaClusterSummary = struct {
    /// Details of an Amazon MSK Cluster.
    amazon_msk_cluster: ?AmazonMskCluster = null,

    /// Details of an Apache Kafka Cluster.
    apache_kafka_cluster: ?ApacheKafkaCluster = null,

    /// The alias of the Kafka cluster. Used to prefix names of replicated topics.
    kafka_cluster_alias: ?[]const u8 = null,

    pub const json_field_names = .{
        .amazon_msk_cluster = "AmazonMskCluster",
        .apache_kafka_cluster = "ApacheKafkaCluster",
        .kafka_cluster_alias = "KafkaClusterAlias",
    };
};
