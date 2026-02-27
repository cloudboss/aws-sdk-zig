/// The KMS key details.
pub const KMSKey = struct {
    /// The encryption key ARN.
    kms_encryption_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .kms_encryption_key_arn = "kmsEncryptionKeyArn",
    };
};
