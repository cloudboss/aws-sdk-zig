const ConnectionPasswordEncryption = @import("connection_password_encryption.zig").ConnectionPasswordEncryption;
const EncryptionAtRest = @import("encryption_at_rest.zig").EncryptionAtRest;

/// Contains configuration information for maintaining Data Catalog security.
pub const DataCatalogEncryptionSettings = struct {
    /// When connection password protection is enabled, the Data Catalog uses a
    /// customer-provided
    /// key to encrypt the password as part of `CreateConnection` or
    /// `UpdateConnection` and store it in the `ENCRYPTED_PASSWORD` field in
    /// the connection properties. You can enable catalog encryption or only
    /// password
    /// encryption.
    connection_password_encryption: ?ConnectionPasswordEncryption = null,

    /// Specifies the encryption-at-rest configuration for the Data Catalog.
    encryption_at_rest: ?EncryptionAtRest = null,

    pub const json_field_names = .{
        .connection_password_encryption = "ConnectionPasswordEncryption",
        .encryption_at_rest = "EncryptionAtRest",
    };
};
