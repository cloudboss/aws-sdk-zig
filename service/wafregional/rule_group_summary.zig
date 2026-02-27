/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains the identifier and the friendly name or description of the
/// `RuleGroup`.
pub const RuleGroupSummary = struct {
    /// A friendly name or description of the RuleGroup. You can't change the name
    /// of a `RuleGroup` after you create it.
    name: []const u8,

    /// A unique identifier for a `RuleGroup`. You use `RuleGroupId` to get more
    /// information about a `RuleGroup` (see GetRuleGroup),
    /// update a `RuleGroup` (see UpdateRuleGroup), insert a `RuleGroup` into a
    /// `WebACL` or delete
    /// one from a `WebACL` (see UpdateWebACL), or delete a `RuleGroup` from AWS WAF
    /// (see DeleteRuleGroup).
    ///
    /// `RuleGroupId` is returned by CreateRuleGroup and by ListRuleGroups.
    rule_group_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .rule_group_id = "RuleGroupId",
    };
};
