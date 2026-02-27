/// A collection of tags associated with a container. Each tag consists of a
/// key:value pair, which can be anything you define. Typically, the tag key
/// represents a category (such as "environment") and the tag value represents a
/// specific value within that category (such as "test," "development," or
/// "production"). You can add up to 50
/// tags to each container. For more information about tagging, including naming
/// and usage conventions, see [Tagging Resources in
/// MediaStore](https://docs.aws.amazon.com/mediastore/latest/ug/tagging.html).
pub const Tag = struct {
    /// Part of the key:value pair that defines a tag. You can use a tag key to
    /// describe a category of information, such as "customer." Tag keys are
    /// case-sensitive.
    key: []const u8,

    /// Part of the key:value pair that defines a tag. You can use a tag value to
    /// describe a specific value within a category, such as "companyA" or
    /// "companyB." Tag values are case-sensitive.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
