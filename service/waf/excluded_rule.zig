/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The rule to exclude from a rule group. This is applicable only when the
/// `ActivatedRule` refers to a `RuleGroup`. The rule must belong to
/// the `RuleGroup` that is specified by the `ActivatedRule`.
pub const ExcludedRule = struct {
    /// The unique identifier for the rule to exclude from the rule group.
    rule_id: []const u8,

    pub const json_field_names = .{
        .rule_id = "RuleId",
    };
};
