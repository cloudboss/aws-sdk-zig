/// Encryption options for a package.
pub const PackageEncryptionOptions = struct {
    /// Whether encryption is enabled for the package.
    encryption_enabled: bool,

    /// KMS key ID for encrypting the package.
    kms_key_identifier: ?[]const u8,

    pub const json_field_names = .{
        .encryption_enabled = "EncryptionEnabled",
        .kms_key_identifier = "KmsKeyIdentifier",
    };
};
