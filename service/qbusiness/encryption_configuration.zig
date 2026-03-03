/// Provides the identifier of the KMS key used to encrypt data indexed by
/// Amazon Q Business. Amazon Q Business doesn't support asymmetric keys.
pub const EncryptionConfiguration = struct {
    /// The identifier of the KMS key. Amazon Q Business doesn't support asymmetric
    /// keys.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
    };
};
