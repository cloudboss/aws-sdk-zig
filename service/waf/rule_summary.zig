/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// Contains the identifier and the friendly name or description of the `Rule`.
pub const RuleSummary = struct {
    /// A friendly name or description of the Rule. You can't change the name of a
    /// `Rule` after you create it.
    name: []const u8,

    /// A unique identifier for a `Rule`. You use `RuleId` to get more information
    /// about a `Rule` (see GetRule),
    /// update a `Rule` (see UpdateRule), insert a `Rule` into a `WebACL` or delete
    /// one from a `WebACL` (see UpdateWebACL), or delete a `Rule` from AWS WAF (see
    /// DeleteRule).
    ///
    /// `RuleId` is returned by CreateRule and by ListRules.
    rule_id: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .rule_id = "RuleId",
    };
};
