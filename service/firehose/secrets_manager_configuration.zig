/// The structure that defines how Firehose accesses the secret.
pub const SecretsManagerConfiguration = struct {
    /// Specifies whether you want to use the secrets manager feature. When set as
    /// `True` the secrets manager configuration overwrites the existing secrets in
    /// the destination configuration. When it's set to `False` Firehose falls back
    /// to
    /// the credentials in the destination configuration.
    enabled: bool,

    /// Specifies the role that Firehose assumes when calling the Secrets Manager
    /// API operation. When you provide the role, it overrides any destination
    /// specific role defined in the destination configuration. If you do not
    /// provide the then we use the destination specific role. This parameter is
    /// required for Splunk.
    role_arn: ?[]const u8 = null,

    /// The ARN of the secret that stores your credentials. It must be in the same
    /// region as the
    /// Firehose stream and the role. The secret ARN can reside in a different
    /// account than the Firehose stream and role as Firehose supports cross-account
    /// secret access. This parameter is required when **Enabled** is set to `True`.
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .role_arn = "RoleARN",
        .secret_arn = "SecretARN",
    };
};
