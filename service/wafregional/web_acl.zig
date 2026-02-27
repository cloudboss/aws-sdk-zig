const WafAction = @import("waf_action.zig").WafAction;
const ActivatedRule = @import("activated_rule.zig").ActivatedRule;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains the `Rules` that identify the requests that you want to allow,
/// block, or count. In a `WebACL`, you also specify a
/// default action (`ALLOW` or `BLOCK`), and the action for each `Rule` that you
/// add to a
/// `WebACL`, for example, block requests from specified IP addresses or block
/// requests from specified referrers.
/// You also associate the `WebACL` with a CloudFront distribution to identify
/// the requests that you want AWS WAF to filter.
/// If you add more than one `Rule` to a `WebACL`, a request needs to match only
/// one of the specifications
/// to be allowed, blocked, or counted. For more information, see UpdateWebACL.
pub const WebACL = struct {
    /// The action to perform if none of the `Rules` contained in the `WebACL`
    /// match. The action is specified by the
    /// WafAction object.
    default_action: WafAction,

    /// A friendly name or description for the metrics for this `WebACL`. The name
    /// can contain only alphanumeric characters (A-Z, a-z, 0-9), with maximum
    /// length 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change `MetricName` after you create the
    /// `WebACL`.
    metric_name: ?[]const u8,

    /// A friendly name or description of the `WebACL`. You can't change the name of
    /// a `WebACL` after you create it.
    name: ?[]const u8,

    /// An array that contains the action for each `Rule` in a `WebACL`, the
    /// priority of the `Rule`,
    /// and the ID of the `Rule`.
    rules: []const ActivatedRule,

    /// Tha Amazon Resource Name (ARN) of the web ACL.
    web_acl_arn: ?[]const u8,

    /// A unique identifier for a `WebACL`. You use `WebACLId` to get information
    /// about a `WebACL`
    /// (see GetWebACL), update a `WebACL` (see UpdateWebACL), and delete a `WebACL`
    /// from AWS WAF
    /// (see DeleteWebACL).
    ///
    /// `WebACLId` is returned by CreateWebACL and by ListWebACLs.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .default_action = "DefaultAction",
        .metric_name = "MetricName",
        .name = "Name",
        .rules = "Rules",
        .web_acl_arn = "WebACLArn",
        .web_acl_id = "WebACLId",
    };
};
