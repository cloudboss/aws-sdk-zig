/// A key-value pair (the value is optional) that you can define and assign to
/// Amazon resources.
/// If you specify a tag that already exists, the tag value is replaced with the
/// value that you
/// specify in the request. Note that
/// the maximum number of application tags includes system tags. The maximum
/// number of user-defined
/// application tags is 50.
/// For more information, see
/// [Using
/// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/java/how-tagging.html).
pub const Tag = struct {
    /// The key of the key-value tag.
    key: []const u8,

    /// The value of the key-value tag. The value is optional.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
