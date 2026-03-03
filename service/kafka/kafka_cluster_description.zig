const AmazonMskCluster = @import("amazon_msk_cluster.zig").AmazonMskCluster;
const KafkaClusterClientVpcConfig = @import("kafka_cluster_client_vpc_config.zig").KafkaClusterClientVpcConfig;

/// Information about Kafka Cluster used as source / target for replication.
pub const KafkaClusterDescription = struct {
    /// Details of an Amazon MSK Cluster.
    amazon_msk_cluster: ?AmazonMskCluster = null,

    /// The alias of the Kafka cluster. Used to prefix names of replicated topics.
    kafka_cluster_alias: ?[]const u8 = null,

    /// Details of an Amazon VPC which has network connectivity to the Apache Kafka
    /// cluster.
    vpc_config: ?KafkaClusterClientVpcConfig = null,

    pub const json_field_names = .{
        .amazon_msk_cluster = "AmazonMskCluster",
        .kafka_cluster_alias = "KafkaClusterAlias",
        .vpc_config = "VpcConfig",
    };
};
