/// Describes a tag.
pub const Tag = struct {
    /// The tag key.
    ///
    /// Constraints: Maximum length of 128 characters.
    key: ?[]const u8,

    /// The tag value.
    ///
    /// Constraints: Maximum length of 256 characters.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
