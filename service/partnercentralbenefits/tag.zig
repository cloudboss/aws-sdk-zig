/// Represents a key-value pair used for categorizing and organizing AWS
/// resources.
pub const Tag = struct {
    /// The tag key, which acts as a category or label for the tag.
    key: []const u8,

    /// The tag value, which provides additional information or context for the tag
    /// key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
