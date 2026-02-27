/// The data structure used by the Data Catalog to encrypt the password as part
/// of
/// `CreateConnection` or `UpdateConnection` and store it in the
/// `ENCRYPTED_PASSWORD` field in the connection properties. You can enable
/// catalog
/// encryption or only password encryption.
///
/// When a `CreationConnection` request arrives containing a password, the Data
/// Catalog first encrypts the password using your KMS key. It then encrypts the
/// whole
/// connection object again if catalog encryption is also enabled.
///
/// This encryption requires that you set KMS key permissions to enable or
/// restrict access
/// on the password key according to your security requirements. For example,
/// you might want only
/// administrators to have decrypt permission on the password key.
pub const ConnectionPasswordEncryption = struct {
    /// An KMS key that is used to encrypt the connection password.
    ///
    /// If connection password protection is enabled, the caller of
    /// `CreateConnection`
    /// and `UpdateConnection` needs at least `kms:Encrypt` permission on the
    /// specified KMS key, to encrypt passwords before storing them in the Data
    /// Catalog.
    ///
    /// You can set the decrypt permission to enable or restrict access on the
    /// password key according to your security requirements.
    aws_kms_key_id: ?[]const u8,

    /// When the `ReturnConnectionPasswordEncrypted` flag is set to "true",
    /// passwords remain encrypted in the responses of `GetConnection` and
    /// `GetConnections`. This encryption takes effect independently from catalog
    /// encryption.
    return_connection_password_encrypted: bool = false,

    pub const json_field_names = .{
        .aws_kms_key_id = "AwsKmsKeyId",
        .return_connection_password_encrypted = "ReturnConnectionPasswordEncrypted",
    };
};
