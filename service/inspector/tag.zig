/// A key and value pair. This data type is used as a request parameter in the
/// SetTagsForResource action and a response element in the ListTagsForResource
/// action.
pub const Tag = struct {
    /// A tag key.
    key: []const u8,

    /// A value assigned to a tag key.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
