/// Provides encryption details of Amazon Security Lake object.
pub const DataLakeEncryptionConfiguration = struct {
    /// The identifier of KMS encryption key used by Amazon Security Lake to encrypt
    /// the Security Lake
    /// object.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
    };
};
