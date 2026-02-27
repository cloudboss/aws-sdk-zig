/// The metadata that you apply to Amazon Web Services resources to help you
/// categorize and organize
/// them. Each tag consists of a key and a value, both of which you define. For
/// more
/// information, see [Tagging Amazon Web Services
/// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
/// in the *Amazon Web Services General Reference*.
pub const Tag = struct {
    /// One part of a key-value pair that makes up a tag. A key is a general label
    /// that acts like a category for more specific tag values.
    key: []const u8,

    /// One part of a key-value pair that make up a tag. A value acts as a
    /// descriptor within a tag category (key). The value can be empty or null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
