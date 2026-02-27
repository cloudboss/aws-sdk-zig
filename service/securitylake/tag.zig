/// A *tag* is a label that you can define and associate with Amazon Web
/// Services resources, including certain types of Amazon Security Lake
/// resources.
/// Tags can help you identify, categorize, and manage resources in different
/// ways, such as by owner, environment, or other criteria. You can associate
/// tags with
/// the following types of Security Lake resources: subscribers, and the data
/// lake configuration for your Amazon Web Services account in individual Amazon
/// Web Services Regions.
///
/// A resource can have up to 50 tags. Each tag consists of a required *tag key*
/// and an associated *tag value*. A
/// *tag key* is a general label that acts as a category for a more specific tag
/// value. Each tag key must be unique and it can have only one tag
/// value. A *tag value* acts as a descriptor for a tag key. Tag keys and values
/// are case sensitive. They can contain letters, numbers, spaces,
/// or the following symbols: _ . : / = + @ -
///
/// For more information, see [Tagging Amazon Security Lake
/// resources](https://docs.aws.amazon.com/security-lake/latest/userguide/tagging-resources.html) in
/// the *Amazon Security Lake User Guide*.
pub const Tag = struct {
    /// The name of the tag. This is a general label that acts as a category for a
    /// more specific tag value (`value`).
    key: []const u8,

    /// The value that’s associated with the specified tag key (`key`). This value
    /// acts as a descriptor for the tag key. A tag value cannot be
    /// null, but it can be an empty string.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
