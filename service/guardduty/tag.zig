/// Contains information about a tag key-value pair.
pub const Tag = struct {
    /// Describes the key associated with the tag.
    key: ?[]const u8 = null,

    /// Describes the value associated with the tag key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
