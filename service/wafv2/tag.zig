/// A tag associated with an Amazon Web Services resource. Tags are key:value
/// pairs that you can use to
/// categorize and manage your resources, for purposes like billing or other
/// management.
/// Typically, the tag key represents a category, such as "environment", and the
/// tag value
/// represents a specific value within that category, such as "test,"
/// "development," or
/// "production". Or you might set the tag key to "customer" and the value to
/// the customer name
/// or ID. You can specify one or more tags to add to each Amazon Web Services
/// resource, up to 50 tags for a
/// resource.
///
/// You can tag the Amazon Web Services resources that you manage through WAF:
/// web ACLs, rule
/// groups, IP sets, and regex pattern sets. You can't manage or view tags
/// through the WAF
/// console.
pub const Tag = struct {
    /// Part of the key:value pair that defines a tag. You can use a tag key to
    /// describe a
    /// category of information, such as "customer." Tag keys are case-sensitive.
    key: []const u8,

    /// Part of the key:value pair that defines a tag. You can use a tag value to
    /// describe a
    /// specific value within a category, such as "companyA" or "companyB." Tag
    /// values are
    /// case-sensitive.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
