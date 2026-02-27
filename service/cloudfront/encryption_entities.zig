const EncryptionEntity = @import("encryption_entity.zig").EncryptionEntity;

/// Complex data type for field-level encryption profiles that includes all of
/// the encryption entities.
pub const EncryptionEntities = struct {
    /// An array of field patterns in a field-level encryption content type-profile
    /// mapping.
    items: ?[]const EncryptionEntity,

    /// Number of field pattern items in a field-level encryption content
    /// type-profile mapping.
    quantity: i32,
};
