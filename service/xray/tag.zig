/// A map that contains tag keys and tag values to attach to an Amazon Web
/// Services X-Ray group or sampling
/// rule. For more information about ways to use tags, see [Tagging Amazon Web
/// Services
/// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
/// in the *Amazon Web Services General Reference*.
///
/// The following restrictions apply to tags:
///
/// * Maximum number of user-applied tags per resource: 50
///
/// * Tag keys and values are case sensitive.
///
/// * Don't use `aws:` as a prefix for keys; it's reserved for Amazon Web
///   Services use. You
/// cannot edit or delete system tags.
pub const Tag = struct {
    /// A tag key, such as `Stage` or `Name`. A tag key cannot be empty. The
    /// key can be a maximum of 128 characters, and can contain only Unicode
    /// letters, numbers, or separators,
    /// or the following special characters: `+ - = . _ : /`
    key: []const u8,

    /// An optional tag value, such as `Production` or `test-only`. The value can be
    /// a maximum of 255 characters, and contain only Unicode letters, numbers, or
    /// separators, or the following
    /// special characters: `+ - = . _ : /`
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
