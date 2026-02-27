/// A description of a resource tag.
pub const Tag = struct {
    /// The key of the resource tag.
    key: []const u8,

    /// The value of the resource tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
