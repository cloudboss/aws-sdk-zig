const FieldLevelEncryptionProfileConfig = @import("field_level_encryption_profile_config.zig").FieldLevelEncryptionProfileConfig;

/// A complex data type for field-level encryption profiles.
pub const FieldLevelEncryptionProfile = struct {
    /// A complex data type that includes the profile name and the encryption
    /// entities for the field-level encryption profile.
    field_level_encryption_profile_config: FieldLevelEncryptionProfileConfig,

    /// The ID for a field-level encryption profile configuration which includes a
    /// set of profiles that specify certain selected data fields to be encrypted by
    /// specific public keys.
    id: []const u8,

    /// The last time the field-level encryption profile was updated.
    last_modified_time: i64,
};
