/// The configuration for a Secrets Manager secret. For more information, see
/// [CreateSecret](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_CreateSecret.html).
///
/// You can propose a configuration for a new secret or an existing secret that
/// you own by specifying the secret policy and optional KMS encryption key. If
/// the configuration is for an existing secret and you do not specify the
/// secret policy, the access preview uses the existing policy for the secret.
/// If the access preview is for a new resource and you do not specify the
/// policy, the access preview assumes a secret without a policy. To propose
/// deletion of an existing policy, you can specify an empty string. If the
/// proposed configuration is for a new secret and you do not specify the KMS
/// key ID, the access preview uses the Amazon Web Services managed key
/// `aws/secretsmanager`. If you specify an empty string for the KMS key ID, the
/// access preview uses the Amazon Web Services managed key of the Amazon Web
/// Services account. For more information about secret policy limits, see
/// [Quotas for Secrets
/// Manager.](https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_limits.html).
pub const SecretsManagerSecretConfiguration = struct {
    /// The proposed ARN, key ID, or alias of the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The proposed resource policy defining who can access or manage the secret.
    secret_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .secret_policy = "secretPolicy",
    };
};
