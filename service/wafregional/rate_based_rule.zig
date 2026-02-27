const Predicate = @import("predicate.zig").Predicate;
const RateKey = @import("rate_key.zig").RateKey;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// A `RateBasedRule` is identical to a regular Rule, with
/// one addition: a `RateBasedRule` counts the number of requests that arrive
/// from a
/// specified IP address every five minutes. For example, based on recent
/// requests that you've
/// seen from an attacker, you might create a `RateBasedRule` that includes the
/// following conditions:
///
/// * The requests come from 192.0.2.44.
///
/// * They contain the value `BadBot` in the `User-Agent`
/// header.
///
/// In the rule, you also define the rate limit as 1,000.
///
/// Requests that meet both of these conditions and exceed 1,000 requests every
/// five
/// minutes trigger the rule's action (block or count), which is defined in the
/// web
/// ACL.
pub const RateBasedRule = struct {
    /// The `Predicates` object contains one `Predicate` element for
    /// each ByteMatchSet, IPSet, or SqlInjectionMatchSet object that you want to
    /// include in a
    /// `RateBasedRule`.
    match_predicates: []const Predicate,

    /// A friendly name or description for the metrics for a `RateBasedRule`. The
    /// name can contain only alphanumeric characters (A-Z, a-z, 0-9), with maximum
    /// length 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change the name of the metric after you create
    /// the
    /// `RateBasedRule`.
    metric_name: ?[]const u8,

    /// A friendly name or description for a `RateBasedRule`. You can't change the
    /// name of a `RateBasedRule` after you create it.
    name: ?[]const u8,

    /// The field that AWS WAF uses to determine if requests are likely arriving
    /// from single
    /// source and thus subject to rate monitoring. The only valid value for
    /// `RateKey`
    /// is `IP`. `IP` indicates that requests arriving from the same IP
    /// address are subject to the `RateLimit` that is specified in the
    /// `RateBasedRule`.
    rate_key: RateKey,

    /// The maximum number of requests, which have an identical value in the field
    /// specified
    /// by the `RateKey`, allowed in a five-minute period. If the number of requests
    /// exceeds the `RateLimit` and the other predicates specified in the rule are
    /// also
    /// met, AWS WAF triggers the action that is specified for this rule.
    rate_limit: i64,

    /// A unique identifier for a `RateBasedRule`. You use `RuleId` to
    /// get more information about a `RateBasedRule` (see GetRateBasedRule), update
    /// a `RateBasedRule` (see UpdateRateBasedRule), insert a `RateBasedRule` into a
    /// `WebACL` or delete one from a `WebACL` (see UpdateWebACL), or delete a
    /// `RateBasedRule` from AWS WAF (see DeleteRateBasedRule).
    rule_id: []const u8,

    pub const json_field_names = .{
        .match_predicates = "MatchPredicates",
        .metric_name = "MetricName",
        .name = "Name",
        .rate_key = "RateKey",
        .rate_limit = "RateLimit",
        .rule_id = "RuleId",
    };
};
