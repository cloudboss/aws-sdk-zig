/// Tag to associate with a schedule group.
pub const Tag = struct {
    /// The key for the tag.
    key: []const u8,

    /// The value for the tag.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
