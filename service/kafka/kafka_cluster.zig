const AmazonMskCluster = @import("amazon_msk_cluster.zig").AmazonMskCluster;
const ApacheKafkaCluster = @import("apache_kafka_cluster.zig").ApacheKafkaCluster;
const KafkaClusterClientAuthentication = @import("kafka_cluster_client_authentication.zig").KafkaClusterClientAuthentication;
const KafkaClusterEncryptionInTransit = @import("kafka_cluster_encryption_in_transit.zig").KafkaClusterEncryptionInTransit;
const KafkaClusterClientVpcConfig = @import("kafka_cluster_client_vpc_config.zig").KafkaClusterClientVpcConfig;

/// Information about Kafka Cluster to be used as source / target for
/// replication.
pub const KafkaCluster = struct {
    /// Details of an Amazon MSK Cluster.
    amazon_msk_cluster: ?AmazonMskCluster = null,

    /// Details of an Apache Kafka Cluster.
    apache_kafka_cluster: ?ApacheKafkaCluster = null,

    /// Details of the client authentication used by the Apache Kafka cluster.
    client_authentication: ?KafkaClusterClientAuthentication = null,

    /// Details of encryption in transit to the Apache Kafka cluster.
    encryption_in_transit: ?KafkaClusterEncryptionInTransit = null,

    /// Details of an Amazon VPC which has network connectivity to the Apache Kafka
    /// cluster.
    vpc_config: ?KafkaClusterClientVpcConfig = null,

    pub const json_field_names = .{
        .amazon_msk_cluster = "AmazonMskCluster",
        .apache_kafka_cluster = "ApacheKafkaCluster",
        .client_authentication = "ClientAuthentication",
        .encryption_in_transit = "EncryptionInTransit",
        .vpc_config = "VpcConfig",
    };
};
