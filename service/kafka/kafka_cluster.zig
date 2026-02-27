const AmazonMskCluster = @import("amazon_msk_cluster.zig").AmazonMskCluster;
const KafkaClusterClientVpcConfig = @import("kafka_cluster_client_vpc_config.zig").KafkaClusterClientVpcConfig;

/// Information about Kafka Cluster to be used as source / target for
/// replication.
pub const KafkaCluster = struct {
    /// Details of an Amazon MSK Cluster.
    amazon_msk_cluster: AmazonMskCluster,

    /// Details of an Amazon VPC which has network connectivity to the Apache Kafka
    /// cluster.
    vpc_config: KafkaClusterClientVpcConfig,

    pub const json_field_names = .{
        .amazon_msk_cluster = "AmazonMskCluster",
        .vpc_config = "VpcConfig",
    };
};
