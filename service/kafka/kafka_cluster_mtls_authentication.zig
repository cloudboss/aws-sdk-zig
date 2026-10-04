/// Details for mTLS client authentication.
pub const KafkaClusterMTLSAuthentication = struct {
    /// The Amazon Resource Name (ARN) of the Secrets Manager secret.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
