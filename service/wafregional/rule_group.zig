/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// A collection of predefined rules that you can add to a web ACL.
///
/// Rule groups are subject to the following limits:
///
/// * Three rule groups per account. You can request an increase to this limit
///   by contacting customer support.
///
/// * One rule group per web ACL.
///
/// * Ten rules per rule group.
pub const RuleGroup = struct {
    /// A friendly name or description for the metrics for this `RuleGroup`. The
    /// name can contain only alphanumeric characters (A-Z, a-z, 0-9), with maximum
    /// length 128 and minimum length one. It can't contain
    /// whitespace or metric names reserved for AWS WAF, including "All" and
    /// "Default_Action." You can't change the name of the metric after you create
    /// the `RuleGroup`.
    metric_name: ?[]const u8,

    /// The friendly name or description for the `RuleGroup`. You can't change the
    /// name of a `RuleGroup` after you create it.
    name: ?[]const u8,

    /// A unique identifier for a `RuleGroup`. You use `RuleGroupId` to get more
    /// information about a `RuleGroup` (see GetRuleGroup),
    /// update a `RuleGroup` (see UpdateRuleGroup), insert a `RuleGroup` into a
    /// `WebACL` or delete a
    /// one from a `WebACL` (see UpdateWebACL), or delete a `RuleGroup` from AWS WAF
    /// (see DeleteRuleGroup).
    ///
    /// `RuleGroupId` is returned by CreateRuleGroup and by ListRuleGroups.
    rule_group_id: []const u8,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .name = "Name",
        .rule_group_id = "RuleGroupId",
    };
};
