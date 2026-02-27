/// Provides details about broker encryption options.
pub const AwsAmazonMqBrokerEncryptionOptionsDetails = struct {
    /// The KMS key that’s used to encrypt your data at rest. If not provided,
    /// Amazon MQ will use a
    /// default KMS key to encrypt your data.
    kms_key_id: ?[]const u8,

    /// Specifies that an KMS key should be used for at-rest encryption. Set to
    /// `true` by default
    /// if no value is provided (for example, for RabbitMQ brokers).
    use_aws_owned_key: ?bool,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .use_aws_owned_key = "UseAwsOwnedKey",
    };
};
