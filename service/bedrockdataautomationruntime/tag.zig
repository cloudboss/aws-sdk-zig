/// Key value pair of a tag
pub const Tag = struct {
    key: []const u8,

    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
