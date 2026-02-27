/// A custom key-value pair associated with an ML object, such as an ML model.
pub const Tag = struct {
    /// A unique identifier for the tag. Valid characters include Unicode letters,
    /// digits, white space, _, ., /, =, +, -, %, and @.
    key: ?[]const u8,

    /// An optional string, typically used to describe or define the tag. Valid
    /// characters include Unicode letters, digits, white space, _, ., /, =, +, -,
    /// %, and @.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
