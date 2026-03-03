/// Describes a tag key and optional value assigned to an Amazon Lightsail
/// resource.
///
/// For more information about tags in Lightsail, see the [Amazon Lightsail
/// Developer
/// Guide](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-tags).
pub const Tag = struct {
    /// The key of the tag.
    ///
    /// Constraints: Tag keys accept a maximum of 128 letters, numbers, spaces in
    /// UTF-8, or the
    /// following characters: + - = . _ : / @
    key: ?[]const u8 = null,

    /// The value of the tag.
    ///
    /// Constraints: Tag values accept a maximum of 256 letters, numbers, spaces in
    /// UTF-8, or the
    /// following characters: + - = . _ : / @
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
