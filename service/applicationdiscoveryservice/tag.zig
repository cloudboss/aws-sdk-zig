/// Metadata that help you categorize IT assets.
///
/// Do not store sensitive information (like personal data) in tags.
pub const Tag = struct {
    /// The type of tag on which to filter.
    key: []const u8,

    /// A value for a tag key on which to filter.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
