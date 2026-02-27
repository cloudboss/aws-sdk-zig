/// Describes a custom encryption key that App Runner uses to encrypt copies of
/// the source repository and service logs.
pub const EncryptionConfiguration = struct {
    /// The ARN of the KMS key that's used for encryption.
    kms_key: []const u8,

    pub const json_field_names = .{
        .kms_key = "KmsKey",
    };
};
