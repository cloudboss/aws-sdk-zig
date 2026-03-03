/// Specifies the Encryption At Rest Options.
pub const EncryptionAtRestOptions = struct {
    /// Specifies the option to enable Encryption At Rest.
    enabled: ?bool = null,

    /// Specifies the KMS Key ID for Encryption At Rest options.
    kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .kms_key_id = "KmsKeyId",
    };
};
