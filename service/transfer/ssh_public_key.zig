/// Provides information about the public Secure Shell (SSH) key that is
/// associated with a Transfer Family user for the specific file transfer
/// protocol-enabled server (as identified by `ServerId`). The information
/// returned includes the date the key was imported, the public key contents,
/// and the public key ID. A user can store more than one SSH public key
/// associated with their user name on a specific server.
pub const SshPublicKey = struct {
    /// Specifies the date that the public key was added to the Transfer Family
    /// user.
    date_imported: i64,

    /// Specifies the content of the SSH public key as specified by the
    /// `PublicKeyId`.
    ///
    /// Transfer Family accepts RSA, ECDSA, and ED25519 keys.
    ssh_public_key_body: []const u8,

    /// Specifies the `SshPublicKeyId` parameter contains the identifier of the
    /// public key.
    ssh_public_key_id: []const u8,

    pub const json_field_names = .{
        .date_imported = "DateImported",
        .ssh_public_key_body = "SshPublicKeyBody",
        .ssh_public_key_id = "SshPublicKeyId",
    };
};
