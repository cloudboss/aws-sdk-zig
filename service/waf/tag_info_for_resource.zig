const Tag = @import("tag.zig").Tag;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Information for a tag associated with an AWS resource. Tags are key:value
/// pairs that you can use to categorize and manage your resources, for purposes
/// like billing. For example, you might set the tag key to "customer" and the
/// value to the customer name or ID. You can specify one or more tags to add to
/// each AWS resource, up to 50 tags for a resource.
///
/// Tagging is only available through the API, SDKs, and CLI. You can't manage
/// or view tags through the AWS WAF Classic console. You can tag the AWS
/// resources that you manage through AWS WAF Classic: web ACLs, rule groups,
/// and rules.
pub const TagInfoForResource = struct {
    resource_arn: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_list = "TagList",
    };
};
