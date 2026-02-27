/// A key value pair.
pub const ListKeysResponseListItem = struct {
    /// The key of the key value pair.
    key: []const u8,

    /// The value of the key value pair.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
