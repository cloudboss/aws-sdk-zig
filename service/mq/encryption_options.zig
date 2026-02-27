/// Encryption options for the broker.
pub const EncryptionOptions = struct {
    /// The customer master key (CMK) to use for the A KMS (KMS). This key is used
    /// to encrypt your data at rest. If not provided, Amazon MQ will use a default
    /// CMK to encrypt your data.
    kms_key_id: ?[]const u8,

    /// Enables the use of an Amazon Web Services owned CMK using KMS (KMS). Set to
    /// true by default, if no value is provided, for example, for RabbitMQ brokers.
    use_aws_owned_key: bool,

    pub const json_field_names = .{
        .kms_key_id = "KmsKeyId",
        .use_aws_owned_key = "UseAwsOwnedKey",
    };
};
