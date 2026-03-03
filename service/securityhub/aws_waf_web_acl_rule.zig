const WafAction = @import("waf_action.zig").WafAction;
const WafExcludedRule = @import("waf_excluded_rule.zig").WafExcludedRule;
const WafOverrideAction = @import("waf_override_action.zig").WafOverrideAction;

/// Details for a rule in an WAF web ACL.
pub const AwsWafWebAclRule = struct {
    /// Specifies the action that CloudFront or WAF takes when a web request matches
    /// the
    /// conditions in the rule.
    action: ?WafAction = null,

    /// Rules to exclude from a rule group.
    excluded_rules: ?[]const WafExcludedRule = null,

    /// Use the `OverrideAction` to test your `RuleGroup`.
    ///
    /// Any rule in a `RuleGroup` can potentially block a request. If you set the
    /// `OverrideAction` to
    /// `None`, the `RuleGroup` blocks a request if any individual rule in the
    /// `RuleGroup`
    /// matches the request and is configured to block that request.
    ///
    /// However, if you first want to test the `RuleGroup`,
    /// set the `OverrideAction` to `Count`. The `RuleGroup`
    /// then overrides any block action specified by individual rules contained
    /// within the group.
    /// Instead of blocking matching requests, those requests are counted.
    ///
    /// `ActivatedRule`|`OverrideAction` applies only when updating or
    /// adding a `RuleGroup`
    /// to a web ACL. In this case you don't use `ActivatedRule`
    /// `Action`. For all other update requests,
    /// `ActivatedRule`
    /// `Action` is used instead of `ActivatedRule`
    /// `OverrideAction`.
    override_action: ?WafOverrideAction = null,

    /// Specifies the order in which the rules in a web
    /// ACL are evaluated. Rules with a lower value for `Priority` are
    /// evaluated before rules with a higher value. The value must be a unique
    /// integer. If you add
    /// multiple rules to a web ACL, the values don't need to be consecutive.
    priority: ?i32 = null,

    /// The identifier for a rule.
    rule_id: ?[]const u8 = null,

    /// The rule type.
    ///
    /// Valid values: `REGULAR` | `RATE_BASED` | `GROUP`
    ///
    /// The default is `REGULAR`.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .excluded_rules = "ExcludedRules",
        .override_action = "OverrideAction",
        .priority = "Priority",
        .rule_id = "RuleId",
        .@"type" = "Type",
    };
};
