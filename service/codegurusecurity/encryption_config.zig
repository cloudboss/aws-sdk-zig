/// Information about the encryption configuration for an account. Required to
/// call `UpdateAccountConfiguration`.
pub const EncryptionConfig = struct {
    /// The KMS key ARN that is used for encryption. If an AWS-managed key is used
    /// for encryption, returns empty.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
    };
};
