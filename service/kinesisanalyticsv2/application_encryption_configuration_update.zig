const KeyType = @import("key_type.zig").KeyType;

/// Describes configuration updates to encryption at rest.
pub const ApplicationEncryptionConfigurationUpdate = struct {
    /// The key ARN, key ID, alias ARN, or alias name of the KMS key to be used for
    /// encryption at rest.
    key_id_update: ?[]const u8,

    /// Specifies the type of key to be used for encryption at rest.
    key_type_update: KeyType,

    pub const json_field_names = .{
        .key_id_update = "KeyIdUpdate",
        .key_type_update = "KeyTypeUpdate",
    };
};
