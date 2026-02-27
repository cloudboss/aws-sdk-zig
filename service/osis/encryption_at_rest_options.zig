/// Options to control how OpenSearch encrypts buffer data.
pub const EncryptionAtRestOptions = struct {
    /// The ARN of the KMS key used to encrypt buffer data.
    /// By default, data is encrypted using an Amazon Web Services owned key.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
    };
};
