const WafOverrideActionType = @import("waf_override_action_type.zig").WafOverrideActionType;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The action to take if any rule within the `RuleGroup` matches a request.
pub const WafOverrideAction = struct {
    /// `COUNT` overrides the action specified by the individual rule within a
    /// `RuleGroup` . If set to `NONE`, the rule's action will take place.
    type: WafOverrideActionType,

    pub const json_field_names = .{
        .type = "Type",
    };
};
