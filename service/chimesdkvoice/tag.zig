/// Describes a tag applied to a resource.
pub const Tag = struct {
    /// The tag's key.
    key: []const u8,

    /// The tag's value.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
