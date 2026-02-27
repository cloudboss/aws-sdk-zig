const AwsSecretsManagerSecretRotationRules = @import("aws_secrets_manager_secret_rotation_rules.zig").AwsSecretsManagerSecretRotationRules;

/// Details about an Secrets Manager secret.
pub const AwsSecretsManagerSecretDetails = struct {
    /// Whether the secret is deleted.
    deleted: ?bool,

    /// The user-provided description of the secret.
    description: ?[]const u8,

    /// The ARN, Key ID, or alias of the KMS key used to encrypt the
    /// `SecretString` or `SecretBinary` values for versions of this
    /// secret.
    kms_key_id: ?[]const u8,

    /// The name of the secret.
    name: ?[]const u8,

    /// Whether rotation is enabled.
    rotation_enabled: ?bool,

    /// The ARN of the Lambda function that rotates the secret.
    rotation_lambda_arn: ?[]const u8,

    /// Whether the rotation occurred within the specified rotation frequency.
    rotation_occurred_within_frequency: ?bool,

    /// Defines the rotation schedule for the secret.
    rotation_rules: ?AwsSecretsManagerSecretRotationRules,

    pub const json_field_names = .{
        .deleted = "Deleted",
        .description = "Description",
        .kms_key_id = "KmsKeyId",
        .name = "Name",
        .rotation_enabled = "RotationEnabled",
        .rotation_lambda_arn = "RotationLambdaArn",
        .rotation_occurred_within_frequency = "RotationOccurredWithinFrequency",
        .rotation_rules = "RotationRules",
    };
};
