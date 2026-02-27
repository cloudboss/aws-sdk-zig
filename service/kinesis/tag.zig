/// Metadata assigned to the stream or consumer, consisting of a key-value pair.
pub const Tag = struct {
    /// A unique identifier for the tag. Maximum length: 128 characters. Valid
    /// characters:
    /// Unicode letters, digits, white space, _ . / = + - % @
    key: []const u8,

    /// An optional string, typically used to describe or define the tag. Maximum
    /// length: 256
    /// characters. Valid characters: Unicode letters, digits, white space, _ . / =
    /// + - %
    /// @
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
