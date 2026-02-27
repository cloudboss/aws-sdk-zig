const aws = @import("aws");

/// Encryption key structure used for Iceberg table encryption. Contains the key
/// ID, encrypted key metadata, optional reference to the encrypting key, and
/// additional properties for the table's encryption scheme.
pub const IcebergEncryptedKey = struct {
    /// Optional ID of the key used to encrypt or wrap the key metadata in Iceberg
    /// table encryption. This field references another encryption key that was used
    /// to encrypt the current key's metadata.
    encrypted_by_id: ?[]const u8,

    /// Encrypted key and metadata, base64 encoded. The format of encrypted key
    /// metadata is determined by the table's encryption scheme and can be a wrapped
    /// format specific to the table's KMS provider.
    encrypted_key_metadata: []const u8,

    /// Unique identifier of the encryption key used for Iceberg table encryption.
    /// This ID is used to reference the key in table metadata and track which key
    /// was used to encrypt specific data.
    key_id: []const u8,

    /// A string to string map of additional metadata used by the table's encryption
    /// scheme. These properties provide additional context and configuration for
    /// the encryption key implementation.
    properties: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .encrypted_by_id = "EncryptedById",
        .encrypted_key_metadata = "EncryptedKeyMetadata",
        .key_id = "KeyId",
        .properties = "Properties",
    };
};
