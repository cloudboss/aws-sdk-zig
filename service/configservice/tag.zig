/// The tags for the resource. The metadata that you apply to a resource to help
/// you categorize and organize them.
/// Each tag consists of a key and an optional value, both of which you define.
/// Tag keys can have a maximum character length of 128 characters, and tag
/// values can have a maximum length of 256 characters.
pub const Tag = struct {
    /// One part of a key-value pair that make up a tag. A key is a general label
    /// that acts like a category for more specific tag values.
    key: ?[]const u8,

    /// The optional part of a key-value pair that make up a tag. A value acts as a
    /// descriptor within a tag category (key).
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
