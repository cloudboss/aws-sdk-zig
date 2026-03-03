/// A tag, consisting of a key and a value.
///
/// This tag is available for use by Amazon Web Services services that support
/// tags in CodeBuild.
pub const Tag = struct {
    /// The tag's key.
    key: ?[]const u8 = null,

    /// The tag's value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
