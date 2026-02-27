/// A list of tag key and value pairs that you define.
pub const Tag = struct {
    /// One part of a key-value pair that makes up a tag. A key is a general
    /// label that acts like a category for more specific tag values.
    key: ?[]const u8,

    /// One part of a key-value pair that make up a tag. A value acts as a
    /// descriptor
    /// within a tag category (key). The value can be empty or null.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
