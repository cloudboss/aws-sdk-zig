const Tag = @import("tag.zig").Tag;

/// The collection of tagging definitions for an Amazon Web Services resource.
/// Tags are key:value pairs
/// that you can use to categorize and manage your resources, for purposes like
/// billing or
/// other management. Typically, the tag key represents a category, such as
/// "environment", and
/// the tag value represents a specific value within that category, such as
/// "test,"
/// "development," or "production". Or you might set the tag key to "customer"
/// and the value to
/// the customer name or ID. You can specify one or more tags to add to each
/// Amazon Web Services resource, up
/// to 50 tags for a resource.
///
/// You can tag the Amazon Web Services resources that you manage through WAF:
/// web ACLs, rule
/// groups, IP sets, and regex pattern sets. You can't manage or view tags
/// through the WAF
/// console.
pub const TagInfoForResource = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    /// The array of Tag objects defined for the resource.
    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_list = "TagList",
    };
};
