pub const DeleteConnectionRequest = struct {
    /// The ID of the connection.
    connection_id: []const u8,

    pub const json_field_names = .{
        .connection_id = "connectionId",
    };
};
