/// This data type is used as one of the elements of the ResourceGroup
/// data type.
pub const ResourceGroupTag = struct {
    /// A tag key.
    key: []const u8,

    /// The value assigned to a tag key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
