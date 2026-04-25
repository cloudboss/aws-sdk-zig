/// Information about the nested item path and hash of the protected resource.
pub const ItemPath = struct {
    /// The hash value of the infected resource.
    hash: ?[]const u8 = null,

    /// The nested item path where the infected file was found.
    nested_item_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .hash = "Hash",
        .nested_item_path = "NestedItemPath",
    };
};
