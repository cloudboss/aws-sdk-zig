/// A key:value pair associated with an Amazon Web Services resource. The
/// key:value pair can be anything you
/// define. Typically, the tag key represents a category (such as "environment")
/// and the tag
/// value represents a specific value within that category (such as "test,"
/// "development," or
/// "production"). You can add up to 50 tags to each Amazon Web Services
/// resource.
pub const Tag = struct {
    /// The part of the key:value pair that defines a tag. You can use a tag key to
    /// describe a
    /// category of information, such as "customer." Tag keys are case-sensitive.
    key: []const u8,

    /// The part of the key:value pair that defines a tag. You can use a tag value
    /// to describe a
    /// specific value within a category, such as "companyA" or "companyB." Tag
    /// values are
    /// case-sensitive.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
