const KafkaClusterClientAuthenticationType = @import("kafka_cluster_client_authentication_type.zig").KafkaClusterClientAuthenticationType;

/// The client authentication information used in order to authenticate with the
/// Apache Kafka cluster.
pub const KafkaClusterClientAuthentication = struct {
    /// The type of client authentication used to connect to the Apache Kafka
    /// cluster. Value NONE means that no client authentication is used.
    authentication_type: KafkaClusterClientAuthenticationType,

    pub const json_field_names = .{
        .authentication_type = "authenticationType",
    };
};
