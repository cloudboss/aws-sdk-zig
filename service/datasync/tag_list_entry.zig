/// A key-value pair representing a single tag that's been applied to an Amazon
/// Web Services
/// resource.
pub const TagListEntry = struct {
    /// The key for an Amazon Web Services resource tag.
    key: []const u8,

    /// The value for an Amazon Web Services resource tag.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
