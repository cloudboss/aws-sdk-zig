/// A structure containing a tag. A tag is metadata that you can attach to your
/// resources
/// to help organize and categorize them. You can also use them to help you
/// secure your
/// resources. For more information, see [Controlling access to Amazon Web
/// Services resources
/// using
/// tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_tags.html).
///
/// For more information about tags, see [Tagging Amazon Web Services
/// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
/// in the
/// *Amazon Web Services General Reference Guide*.
pub const Tag = struct {
    /// The key, or name, attached to the tag. Every tag must have a key. Key names
    /// are case
    /// sensitive.
    key: ?[]const u8,

    /// The string value attached to the tag. The value can be an empty string. Key
    /// values are
    /// case sensitive.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
