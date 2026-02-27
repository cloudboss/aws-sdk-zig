/// A list of objects specifying each key name and value.
pub const Tag = struct {
    /// The key associated with the tag.
    key: []const u8,

    /// The value associated with the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
