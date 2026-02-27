/// Describes a tag. A tag is a key-value pair. You can add up to 50 tags to a
/// single Amazon Keyspaces resource.
///
/// Amazon Web Services-assigned tag names and values are automatically assigned
/// the `aws:` prefix, which the user cannot assign. Amazon Web
/// Services-assigned tag names do not count towards the tag limit of 50.
/// User-assigned tag names have the prefix `user:` in the Cost Allocation
/// Report. You cannot backdate the application of a tag.
///
/// For more information, see [Adding tags and labels to Amazon Keyspaces
/// resources](https://docs.aws.amazon.com/keyspaces/latest/devguide/tagging-keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
pub const Tag = struct {
    /// The key of the tag. Tag keys are case sensitive. Each Amazon Keyspaces
    /// resource can only have up to one tag with the same key. If you try to add an
    /// existing tag (same key), the existing tag value will be updated to the new
    /// value.
    key: []const u8,

    /// The value of the tag. Tag values are case-sensitive and can be null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
