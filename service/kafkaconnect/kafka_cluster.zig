const ApacheKafkaCluster = @import("apache_kafka_cluster.zig").ApacheKafkaCluster;

/// The details of the Apache Kafka cluster to which the connector is connected.
pub const KafkaCluster = struct {
    /// The Apache Kafka cluster to which the connector is connected.
    apache_kafka_cluster: ApacheKafkaCluster,

    pub const json_field_names = .{
        .apache_kafka_cluster = "apacheKafkaCluster",
    };
};
