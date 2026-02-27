const RuleAction = @import("rule_action.zig").RuleAction;
const CaptchaConfig = @import("captcha_config.zig").CaptchaConfig;
const ChallengeConfig = @import("challenge_config.zig").ChallengeConfig;
const OverrideAction = @import("override_action.zig").OverrideAction;
const Label = @import("label.zig").Label;
const Statement = @import("statement.zig").Statement;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

/// A single rule, which you can use in a WebACL or RuleGroup to identify web
/// requests that you want to manage in some way.
/// Each rule includes one top-level Statement that WAF uses to
/// identify matching web requests, and parameters that govern how WAF handles
/// them.
pub const Rule = struct {
    /// The action that WAF should take on a web request when it matches the rule
    /// statement. Settings at the web ACL level can override the rule action
    /// setting.
    ///
    /// This is used only for rules whose statements do not reference a rule group.
    /// Rule statements that reference a rule group include
    /// `RuleGroupReferenceStatement` and `ManagedRuleGroupStatement`.
    ///
    /// You must specify either this `Action` setting or the rule `OverrideAction`
    /// setting, but not both:
    ///
    /// * If the rule statement does not reference a rule group, use this rule
    ///   action setting and not the rule override action setting.
    ///
    /// * If the rule statement references a rule group, use the override action
    ///   setting and not this action setting.
    action: ?RuleAction,

    /// Specifies how WAF should handle `CAPTCHA` evaluations. If you don't specify
    /// this, WAF uses the `CAPTCHA` configuration that's defined for the web ACL.
    captcha_config: ?CaptchaConfig,

    /// Specifies how WAF should handle `Challenge` evaluations. If you don't
    /// specify this, WAF uses the challenge configuration that's defined for the
    /// web ACL.
    challenge_config: ?ChallengeConfig,

    /// The name of the rule.
    ///
    /// If you change the name of a `Rule` after you create
    /// it and you want the rule's metric name to reflect the change, update the
    /// metric name in the rule's `VisibilityConfig` settings. WAF
    /// doesn't automatically update the metric name when you update the rule name.
    name: []const u8,

    /// The action to use in the place of the action that results from the rule
    /// group evaluation. Set the override action to none to leave the result of the
    /// rule group alone. Set it to count to override the result to count only.
    ///
    /// You can only use this for rule statements that reference a rule group, like
    /// `RuleGroupReferenceStatement` and `ManagedRuleGroupStatement`.
    ///
    /// This option is usually set to none. It does not affect how the rules in the
    /// rule group are evaluated. If you want the rules in the rule group to only
    /// count
    /// matches, do not use this and instead use the rule action override option,
    /// with `Count` action, in your rule group reference statement settings.
    override_action: ?OverrideAction,

    /// If you define more than one `Rule` in a `WebACL`, WAF
    /// evaluates each request against the `Rules` in order based on the value of
    /// `Priority`. WAF processes rules with lower priority first. The priorities
    /// don't need to be consecutive, but they must all be different.
    priority: i32 = 0,

    /// Labels to apply to web requests that match the rule match statement. WAF
    /// applies
    /// fully qualified labels to matching web requests. A fully qualified label is
    /// the
    /// concatenation of a label namespace and a rule label. The rule's rule group
    /// or web ACL
    /// defines the label namespace.
    ///
    /// Any rule that isn't a rule group reference statement or managed rule group
    /// statement can add labels to matching web requests.
    ///
    /// Rules that run after this rule in the web ACL can match against these labels
    /// using a
    /// `LabelMatchStatement`.
    ///
    /// For each label, provide a case-sensitive string containing optional
    /// namespaces and a
    /// label name, according to the following guidelines:
    ///
    /// * Separate each component of the label with a colon.
    ///
    /// * Each namespace or name can have up to 128 characters.
    ///
    /// * You can specify up to 5 namespaces in a label.
    ///
    /// * Don't use the following reserved words in your label specification:
    /// `aws`, `waf`, `managed`, `rulegroup`,
    /// `webacl`, `regexpatternset`, or `ipset`.
    ///
    /// For example, `myLabelName` or `nameSpace1:nameSpace2:myLabelName`.
    rule_labels: ?[]const Label,

    /// The WAF processing statement for the rule, for example ByteMatchStatement or
    /// SizeConstraintStatement.
    statement: Statement,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    ///
    /// If you change the name of a `Rule` after you create
    /// it and you want the rule's metric name to reflect the change, update the
    /// metric name as well. WAF
    /// doesn't automatically update the metric name.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .action = "Action",
        .captcha_config = "CaptchaConfig",
        .challenge_config = "ChallengeConfig",
        .name = "Name",
        .override_action = "OverrideAction",
        .priority = "Priority",
        .rule_labels = "RuleLabels",
        .statement = "Statement",
        .visibility_config = "VisibilityConfig",
    };
};
