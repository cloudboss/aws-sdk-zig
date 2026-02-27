/// The configuration settings for transit encryption using Secrets Manager,
/// including the secret ARN and role ARN.
pub const SecretsManagerEncryptionKeyConfiguration = struct {
    /// The ARN of the IAM role assumed by MediaConnect to access the Secrets
    /// Manager secret.
    role_arn: []const u8,

    /// The ARN of the Secrets Manager secret used for transit encryption.
    secret_arn: []const u8,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
        .secret_arn = "SecretArn",
    };
};
