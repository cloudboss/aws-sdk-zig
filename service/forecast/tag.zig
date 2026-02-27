/// The optional metadata that you apply to a resource to help you categorize
/// and organize
/// them. Each tag consists of a key and an optional value, both of which you
/// define.
///
/// The following basic restrictions apply to tags:
///
/// * Maximum number of tags per resource - 50.
///
/// * For each resource, each tag key must be unique, and each tag key can have
///   only one
/// value.
///
/// * Maximum key length - 128 Unicode characters in UTF-8.
///
/// * Maximum value length - 256 Unicode characters in UTF-8.
///
/// * If your tagging schema is used across multiple services and resources,
///   remember that
/// other services may have restrictions on allowed characters. Generally
/// allowed characters
/// are: letters, numbers, and spaces representable in UTF-8, and the following
/// characters: +
/// - = . _ : / @.
///
/// * Tag keys and values are case sensitive.
///
/// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination
/// of such as a prefix for keys as it is reserved for Amazon Web Services use.
/// You cannot edit or delete tag
/// keys with this prefix. Values can have this prefix. If a tag value has `aws`
/// as
/// its prefix but the key does not, then Forecast considers it to be a user tag
/// and will
/// count against the limit of 50 tags. Tags with only the key prefix of `aws`
/// do
/// not count against your tags per resource limit.
pub const Tag = struct {
    /// One part of a key-value pair that makes up a tag. A `key` is a general label
    /// that acts like a category for more specific tag values.
    key: []const u8,

    /// The optional part of a key-value pair that makes up a tag. A `value` acts as
    /// a
    /// descriptor within a tag category (key).
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
