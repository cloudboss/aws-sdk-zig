pub const DeleteChannelRequest = struct {
    /// The ID of the Channel to delete.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
