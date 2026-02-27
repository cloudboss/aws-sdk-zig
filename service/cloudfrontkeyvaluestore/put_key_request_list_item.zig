/// List item for key value pair to put.
pub const PutKeyRequestListItem = struct {
    /// The key of the key value pair list item to put.
    key: []const u8,

    /// The value for the key value pair to put.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
