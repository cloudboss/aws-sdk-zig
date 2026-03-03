const HTTPRequest = @import("http_request.zig").HTTPRequest;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The response from a GetSampledRequests request includes a
/// `SampledHTTPRequests` complex type that
/// appears as `SampledRequests` in the response syntax. `SampledHTTPRequests`
/// contains one
/// `SampledHTTPRequest` object for each web request that is returned by
/// `GetSampledRequests`.
pub const SampledHTTPRequest = struct {
    /// The action for the `Rule` that the request matched: `ALLOW`, `BLOCK`, or
    /// `COUNT`.
    action: ?[]const u8 = null,

    /// A complex type that contains detailed information about the request.
    request: HTTPRequest,

    /// This value is returned if the `GetSampledRequests` request specifies the ID
    /// of a `RuleGroup` rather than the ID of an individual rule.
    /// `RuleWithinRuleGroup` is the rule within the specified `RuleGroup` that
    /// matched the request listed in the response.
    rule_within_rule_group: ?[]const u8 = null,

    /// The time at which AWS WAF received the request from your AWS resource, in
    /// Unix time format (in seconds).
    timestamp: ?i64 = null,

    /// A value that indicates how one result in the response relates proportionally
    /// to other results in the response.
    /// A result that has a weight of `2` represents roughly twice as many
    /// CloudFront web requests as a result
    /// that has a weight of `1`.
    weight: i64 = 0,

    pub const json_field_names = .{
        .action = "Action",
        .request = "Request",
        .rule_within_rule_group = "RuleWithinRuleGroup",
        .timestamp = "Timestamp",
        .weight = "Weight",
    };
};
