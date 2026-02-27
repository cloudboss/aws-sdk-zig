const EncryptionKeyType = @import("encryption_key_type.zig").EncryptionKeyType;

/// Represents information about the key used to encrypt data in the artifact
/// store,
/// such as an Amazon Web Services Key Management Service (Key Management
/// Service)
/// key.
pub const EncryptionKey = struct {
    /// The ID used to identify the key. For an Amazon Web Services KMS key, you can
    /// use the
    /// key ID, the key ARN, or the alias ARN.
    ///
    /// Aliases are recognized only in the account that created the KMS
    /// key. For cross-account actions, you can only use the key ID or key ARN to
    /// identify
    /// the key. Cross-account actions involve using the role from the other account
    /// (AccountB), so specifying the key ID will use the key from the other account
    /// (AccountB).
    id: []const u8,

    /// The type of encryption key, such as an Amazon Web Services KMS key. When
    /// creating or
    /// updating a pipeline, the value must be set to 'KMS'.
    @"type": EncryptionKeyType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
