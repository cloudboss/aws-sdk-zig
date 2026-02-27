pub const UpdateConnectionRequest = struct {
    /// The ID of the connection.
    ///
    /// You can use DescribeConnections to retrieve the connection ID.
    connection_id: []const u8,

    /// The name of the connection.
    connection_name: ?[]const u8,

    /// The connection MAC Security (MACsec) encryption mode.
    ///
    /// The valid values are `no_encrypt`, `should_encrypt`, and `must_encrypt`.
    encryption_mode: ?[]const u8,

    pub const json_field_names = .{
        .connection_id = "connectionId",
        .connection_name = "connectionName",
        .encryption_mode = "encryptionMode",
    };
};
