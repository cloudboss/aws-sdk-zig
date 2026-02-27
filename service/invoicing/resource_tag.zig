/// The tag structure that contains a tag key and value.
pub const ResourceTag = struct {
    /// The object key of your of your resource tag.
    key: []const u8,

    /// The specific value of the resource tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
