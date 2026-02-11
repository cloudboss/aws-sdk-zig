/// Details for the requested item.
pub const ItemResponse = struct {
    /// Map of attribute data consisting of the data type and attribute value.
    item: ?[]const u8,

    pub const json_field_names = .{
        .item = "Item",
    };
};
