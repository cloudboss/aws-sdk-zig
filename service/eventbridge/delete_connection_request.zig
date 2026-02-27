pub const DeleteConnectionRequest = struct {
    /// The name of the connection to delete.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
