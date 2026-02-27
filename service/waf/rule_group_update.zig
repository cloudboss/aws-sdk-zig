const ChangeAction = @import("change_action.zig").ChangeAction;
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
/// Specifies an `ActivatedRule` and indicates whether you want to add it to a
/// `RuleGroup` or delete it from a `RuleGroup`.
pub const RuleGroupUpdate = struct {
    /// Specify `INSERT` to add an `ActivatedRule` to a `RuleGroup`. Use `DELETE` to
    /// remove an
    /// `ActivatedRule` from a `RuleGroup`.
    action: ChangeAction,

    /// The `ActivatedRule` object specifies a `Rule` that you want to insert or
    /// delete,
    /// the priority of the `Rule` in the `WebACL`, and the action that you want AWS
    /// WAF to take when a web request matches the `Rule`
    /// (`ALLOW`, `BLOCK`, or `COUNT`).
    activated_rule: ActivatedRule,

    pub const json_field_names = .{
        .action = "Action",
        .activated_rule = "ActivatedRule",
    };
};
