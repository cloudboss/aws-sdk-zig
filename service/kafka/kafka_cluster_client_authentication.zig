const KafkaClusterMTLSAuthentication = @import("kafka_cluster_mtls_authentication.zig").KafkaClusterMTLSAuthentication;
const KafkaClusterSaslOAuthBearerAuthentication = @import("kafka_cluster_sasl_o_auth_bearer_authentication.zig").KafkaClusterSaslOAuthBearerAuthentication;
const KafkaClusterSaslScramAuthentication = @import("kafka_cluster_sasl_scram_authentication.zig").KafkaClusterSaslScramAuthentication;

/// Details of the client authentication used by the Apache Kafka cluster.
pub const KafkaClusterClientAuthentication = struct {
    /// Details for mTLS client authentication.
    mtls: ?KafkaClusterMTLSAuthentication = null,

    /// Details for SASL/OAUTHBEARER client authentication.
    sasl_o_auth_bearer: ?KafkaClusterSaslOAuthBearerAuthentication = null,

    /// Details for SASL/SCRAM client authentication.
    sasl_scram: ?KafkaClusterSaslScramAuthentication = null,

    pub const json_field_names = .{
        .mtls = "MTLS",
        .sasl_o_auth_bearer = "SaslOAuthBearer",
        .sasl_scram = "SaslScram",
    };
};
