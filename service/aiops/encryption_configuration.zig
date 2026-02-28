const EncryptionConfigurationType = @import("encryption_configuration_type.zig").EncryptionConfigurationType;

/// Use this structure to specify a customer managed KMS key to use to encrypt
/// investigation data.
pub const EncryptionConfiguration = struct {
    /// If the investigation group uses a customer managed key for encryption, this
    /// field displays the ID of that key.
    kms_key_id: ?[]const u8,

    /// Displays whether investigation data is encrypted by a customer managed key
    /// or an Amazon Web Services owned key.
    type: ?EncryptionConfigurationType,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .type = "type",
    };
};
