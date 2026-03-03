/// Describes a tag.
pub const Tag = struct {
    /// The key of the tag.
    key: []const u8,

    /// The value of the tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
