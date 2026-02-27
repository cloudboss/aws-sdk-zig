/// List item for keys to delete.
pub const DeleteKeyRequestListItem = struct {
    /// The key of the key value pair to be deleted.
    key: []const u8,

    pub const json_field_names = .{
        .key = "Key",
    };
};
