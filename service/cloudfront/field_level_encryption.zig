const FieldLevelEncryptionConfig = @import("field_level_encryption_config.zig").FieldLevelEncryptionConfig;

/// A complex data type that includes the profile configurations and other
/// options specified for field-level encryption.
pub const FieldLevelEncryption = struct {
    /// A complex data type that includes the profile configurations specified for
    /// field-level encryption.
    field_level_encryption_config: FieldLevelEncryptionConfig,

    /// The configuration ID for a field-level encryption configuration which
    /// includes a set of profiles that specify certain selected data fields to be
    /// encrypted by specific public keys.
    id: []const u8,

    /// The last time the field-level encryption configuration was changed.
    last_modified_time: i64,
};
