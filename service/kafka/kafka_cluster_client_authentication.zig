const KafkaClusterSaslScramAuthentication = @import("kafka_cluster_sasl_scram_authentication.zig").KafkaClusterSaslScramAuthentication;

/// Details of the client authentication used by the Apache Kafka cluster.
pub const KafkaClusterClientAuthentication = struct {
    /// Details for SASL/SCRAM client authentication.
    sasl_scram: KafkaClusterSaslScramAuthentication,

    pub const json_field_names = .{
        .sasl_scram = "SaslScram",
    };
};
