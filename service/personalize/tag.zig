/// The optional metadata that you apply to resources to help you categorize and
/// organize them. Each tag consists of a key and an optional value, both of
/// which you define.
/// For more information see [Tagging Amazon Personalize
/// resources](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html).
pub const Tag = struct {
    /// One part of a key-value pair that makes up a tag. A key is a general label
    /// that acts like a category for more specific tag values.
    tag_key: []const u8,

    /// The optional part of a key-value pair that makes up a tag. A value acts as a
    /// descriptor within a tag category (key).
    tag_value: []const u8,

    pub const json_field_names = .{
        .tag_key = "tagKey",
        .tag_value = "tagValue",
    };
};
