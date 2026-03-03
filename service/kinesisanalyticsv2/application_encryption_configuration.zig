const KeyType = @import("key_type.zig").KeyType;

/// Specifies the configuration to manage encryption at rest.
pub const ApplicationEncryptionConfiguration = struct {
    /// The key ARN, key ID, alias ARN, or alias name of the KMS key used for
    /// encryption at rest.
    key_id: ?[]const u8 = null,

    /// Specifies the type of key used for encryption at rest.
    key_type: KeyType,

    pub const json_field_names = .{
        .key_id = "KeyId",
        .key_type = "KeyType",
    };
};
