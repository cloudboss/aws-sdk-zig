const Predicate = @import("predicate.zig").Predicate;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// A combination of ByteMatchSet, IPSet, and/or SqlInjectionMatchSet objects
/// that identify the web requests that you
/// want to allow, block, or count. For example, you might create a `Rule` that
/// includes the following predicates:
///
/// * An `IPSet` that causes AWS WAF to search for web requests that originate
///   from the IP address `192.0.2.44`
///
/// * A `ByteMatchSet` that causes AWS WAF to search for web requests for which
///   the value of the `User-Agent`
/// header is `BadBot`.
///
/// To match the settings in this `Rule`, a request must originate from
/// `192.0.2.44` AND include a `User-Agent`
/// header for which the value is `BadBot`.
pub const Rule = struct {
    /// A friendly name or description for the metrics for this `Rule`. The name can
    /// contain only alphanumeric characters (A-Z, a-z, 0-9), with maximum length
    /// 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change `MetricName` after you create the `Rule`.
    metric_name: ?[]const u8,

    /// The friendly name or description for the `Rule`. You can't change the name
    /// of a `Rule` after you create it.
    name: ?[]const u8,

    /// The `Predicates` object contains one `Predicate` element for each
    /// ByteMatchSet, IPSet, or
    /// SqlInjectionMatchSet object that you want to include in a `Rule`.
    predicates: []const Predicate,

    /// A unique identifier for a `Rule`. You use `RuleId` to get more information
    /// about a `Rule` (see GetRule),
    /// update a `Rule` (see UpdateRule), insert a `Rule` into a `WebACL` or delete
    /// a
    /// one from a `WebACL` (see UpdateWebACL), or delete a `Rule` from AWS WAF (see
    /// DeleteRule).
    ///
    /// `RuleId` is returned by CreateRule and by ListRules.
    rule_id: []const u8,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .predicates = "Predicates",
        .rule_id = "RuleId",
    };
};
