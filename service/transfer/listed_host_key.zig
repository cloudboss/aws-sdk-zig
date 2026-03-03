/// Returns properties of the host key that's specified.
pub const ListedHostKey = struct {
    /// The unique Amazon Resource Name (ARN) of the host key.
    arn: []const u8,

    /// The date on which the host key was added to the server.
    date_imported: ?i64 = null,

    /// The current description for the host key. You can change it by calling the
    /// `UpdateHostKey` operation and providing a new description.
    description: ?[]const u8 = null,

    /// The public key fingerprint, which is a short sequence of bytes used to
    /// identify the longer public key.
    fingerprint: ?[]const u8 = null,

    /// A unique identifier for the host key.
    host_key_id: ?[]const u8 = null,

    /// The encryption algorithm that is used for the host key. The `Type` parameter
    /// is specified by using one of the following values:
    ///
    /// * `ssh-rsa`
    /// * `ssh-ed25519`
    /// * `ecdsa-sha2-nistp256`
    /// * `ecdsa-sha2-nistp384`
    /// * `ecdsa-sha2-nistp521`
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .date_imported = "DateImported",
        .description = "Description",
        .fingerprint = "Fingerprint",
        .host_key_id = "HostKeyId",
        .@"type" = "Type",
    };
};
