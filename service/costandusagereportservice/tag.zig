/// Describes a tag. A tag is a key-value pair. You can add up to 50 tags to a
/// report
/// definition.
pub const Tag = struct {
    /// The key of the tag. Tag keys are case sensitive. Each report definition can
    /// only have up
    /// to one tag with the same key. If you try to add an existing tag with the
    /// same key, the
    /// existing tag value will be updated to the new value.
    key: []const u8,

    /// The value of the tag. Tag values are case-sensitive. This can be an empty
    /// string.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
