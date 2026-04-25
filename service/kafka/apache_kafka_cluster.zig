/// Details of an Apache Kafka Cluster.
pub const ApacheKafkaCluster = struct {
    /// The ID of the Apache Kafka cluster.
    apache_kafka_cluster_id: []const u8,

    /// The bootstrap broker string of the Apache Kafka cluster.
    bootstrap_broker_string: []const u8,

    pub const json_field_names = .{
        .apache_kafka_cluster_id = "ApacheKafkaClusterId",
        .bootstrap_broker_string = "BootstrapBrokerString",
    };
};
