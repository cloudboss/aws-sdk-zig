/// Specifies configuration information for a customer-managed Secrets Manager
/// secret where
/// a storage location credentials is stored in Secrets Manager as plain text
/// (for authentication
/// token, secret key, or password) or as binary (for Kerberos keytab). This
/// configuration includes
/// the secret ARN, and the ARN for an IAM role that provides access to the
/// secret.
///
/// You can use either `CmkSecretConfig` or `CustomSecretConfig` to
/// provide credentials for a `CreateLocation` request. Do not provide both
/// parameters for the same request.
pub const CustomSecretConfig = struct {
    /// Specifies the ARN for the Identity and Access Management role that DataSync
    /// uses to
    /// access the secret specified for `SecretArn`.
    secret_access_role_arn: ?[]const u8,

    /// Specifies the ARN for an Secrets Manager secret.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .secret_access_role_arn = "SecretAccessRoleArn",
        .secret_arn = "SecretArn",
    };
};
