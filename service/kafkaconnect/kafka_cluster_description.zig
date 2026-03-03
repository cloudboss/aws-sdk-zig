const ApacheKafkaClusterDescription = @import("apache_kafka_cluster_description.zig").ApacheKafkaClusterDescription;

/// Details of how to connect to the Apache Kafka cluster.
pub const KafkaClusterDescription = struct {
    /// The Apache Kafka cluster to which the connector is connected.
    apache_kafka_cluster: ?ApacheKafkaClusterDescription = null,

    pub const json_field_names = .{
        .apache_kafka_cluster = "apacheKafkaCluster",
    };
};
