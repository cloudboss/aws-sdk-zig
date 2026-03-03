/// Specifies configuration information for a DataSync-managed secret, such as
/// an
/// authentication token or set of credentials that DataSync uses to access a
/// specific
/// transfer location. DataSync uses the default Amazon Web Services-managed KMS
/// key to encrypt this secret in Secrets Manager.
pub const ManagedSecretConfig = struct {
    /// Specifies the ARN for an Secrets Manager secret.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
