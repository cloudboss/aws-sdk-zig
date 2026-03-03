const EncryptionEntities = @import("encryption_entities.zig").EncryptionEntities;

/// The field-level encryption profile summary.
pub const FieldLevelEncryptionProfileSummary = struct {
    /// An optional comment for the field-level encryption profile summary. The
    /// comment cannot be longer than 128 characters.
    comment: ?[]const u8 = null,

    /// A complex data type of encryption entities for the field-level encryption
    /// profile that include the public key ID, provider, and field patterns for
    /// specifying which fields to encrypt with this key.
    encryption_entities: EncryptionEntities,

    /// ID for the field-level encryption profile summary.
    id: []const u8,

    /// The time when the field-level encryption profile summary was last updated.
    last_modified_time: i64,

    /// Name for the field-level encryption profile summary.
    name: []const u8,
};
