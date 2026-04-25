const KafkaClusterSaslScramMechanism = @import("kafka_cluster_sasl_scram_mechanism.zig").KafkaClusterSaslScramMechanism;

/// Details for SASL/SCRAM client authentication.
pub const KafkaClusterSaslScramAuthentication = struct {
    /// The SASL/SCRAM authentication mechanism.
    mechanism: KafkaClusterSaslScramMechanism,

    /// The Amazon Resource Name (ARN) of the Secrets Manager secret.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .mechanism = "Mechanism",
        .secret_arn = "SecretArn",
    };
};
