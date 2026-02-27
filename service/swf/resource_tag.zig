/// Tags are key-value pairs that can be associated with Amazon SWF state
/// machines and
/// activities.
///
/// Tags may only contain unicode letters, digits, whitespace, or these symbols:
/// `_ . : / = + - @`.
pub const ResourceTag = struct {
    /// The key of a tag.
    key: []const u8,

    /// The value of a tag.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
