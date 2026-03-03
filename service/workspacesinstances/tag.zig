/// Represents a key-value metadata tag.
pub const Tag = struct {
    /// Unique identifier for the tag.
    key: ?[]const u8 = null,

    /// Value associated with the tag key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
