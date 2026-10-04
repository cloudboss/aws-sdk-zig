/// The AWS KMS encryption configuration applied to data at rest.
pub const EncryptionConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the AWS KMS key used to encrypt the data.
    kms_key_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "KmsKeyArn",
    };
};
