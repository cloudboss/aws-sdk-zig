const HostKeyStorageType = @import("host_key_storage_type.zig").HostKeyStorageType;
const Tag = @import("tag.zig").Tag;

/// The details for a server host key.
pub const DescribedHostKey = struct {
    /// The unique Amazon Resource Name (ARN) for the host key.
    arn: []const u8,

    /// The date on which the host key was added to the server.
    date_imported: ?i64 = null,

    /// The text description for this host key.
    description: ?[]const u8 = null,

    /// The public key fingerprint, which is a short sequence of bytes used to
    /// identify the longer public key.
    host_key_fingerprint: ?[]const u8 = null,

    /// A unique identifier for the host key.
    host_key_id: ?[]const u8 = null,

    /// The ARN of the Secrets Manager secret that stores the host key material,
    /// when `StorageType` is `SECRETS_MANAGER`.
    secret_id: ?[]const u8 = null,

    /// Specifies whether the host key is stored by Transfer Family
    /// (`SERVICE_MANAGED`) or in Secrets Manager (`SECRETS_MANAGER`).
    storage_type: ?HostKeyStorageType = null,

    /// Key-value pairs that can be used to group and search for host keys.
    tags: ?[]const Tag = null,

    /// The encryption algorithm that is used for the host key. The `Type` parameter
    /// is specified by using one of the following values:
    ///
    /// * `ssh-rsa`
    /// * `ssh-ed25519`
    /// * `ecdsa-sha2-nistp256`
    /// * `ecdsa-sha2-nistp384`
    /// * `ecdsa-sha2-nistp521`
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .date_imported = "DateImported",
        .description = "Description",
        .host_key_fingerprint = "HostKeyFingerprint",
        .host_key_id = "HostKeyId",
        .secret_id = "SecretId",
        .storage_type = "StorageType",
        .tags = "Tags",
        .type = "Type",
    };
};
