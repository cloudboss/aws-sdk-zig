const EncryptionEntities = @import("encryption_entities.zig").EncryptionEntities;

/// A complex data type of profiles for the field-level encryption.
pub const FieldLevelEncryptionProfileConfig = struct {
    /// A unique number that ensures that the request can't be replayed.
    caller_reference: []const u8,

    /// An optional comment for the field-level encryption profile. The comment
    /// cannot be longer than 128 characters.
    comment: ?[]const u8 = null,

    /// A complex data type of encryption entities for the field-level encryption
    /// profile that include the public key ID, provider, and field patterns for
    /// specifying which fields to encrypt with this key.
    encryption_entities: EncryptionEntities,

    /// Profile name for the field-level encryption profile.
    name: []const u8,
};
