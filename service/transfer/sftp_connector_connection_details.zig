/// Contains the details for an SFTP connector connection.
pub const SftpConnectorConnectionDetails = struct {
    /// The SSH public key of the remote SFTP server. This is returned during the
    /// initial connection attempt when you call `TestConnection`. It allows you to
    /// retrieve the valid server host key to update the connector when you are
    /// unable to obtain it in advance.
    host_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .host_key = "HostKey",
    };
};
