const aws = @import("aws");

const LabelSummary = @import("label_summary.zig").LabelSummary;
const CustomResponseBody = @import("custom_response_body.zig").CustomResponseBody;
const Rule = @import("rule.zig").Rule;
const VisibilityConfig = @import("visibility_config.zig").VisibilityConfig;

/// A rule group defines a collection of rules to inspect and control web
/// requests that you can use in a WebACL. When you create a rule group, you
/// define an immutable capacity limit. If you update a rule group, you must
/// stay within the capacity. This allows others to reuse the rule group with
/// confidence in its capacity requirements.
pub const RuleGroup = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: []const u8,

    /// The labels that one or more rules in this rule group add to matching web
    /// requests. These labels are defined in the `RuleLabels` for a Rule.
    available_labels: ?[]const LabelSummary = null,

    /// The web ACL capacity units (WCUs) required for this rule group.
    ///
    /// When you create your own rule group, you define this, and you cannot change
    /// it after creation.
    /// When you add or modify the rules in a rule group, WAF enforces this limit.
    /// You can check the capacity
    /// for a set of rules using CheckCapacity.
    ///
    /// WAF uses WCUs to calculate and control the operating
    /// resources that are used to run your rules, rule groups, and web ACLs. WAF
    /// calculates capacity differently for each rule type, to reflect the relative
    /// cost of each rule.
    /// Simple rules that cost little to run use fewer WCUs than more complex rules
    /// that use more processing power.
    /// Rule group capacity is fixed at creation, which helps users plan their
    /// web ACL WCU usage when they use a rule group. For more information, see [WAF
    /// web ACL capacity units
    /// (WCU)](https://docs.aws.amazon.com/waf/latest/developerguide/aws-waf-capacity-units.html)
    /// in the *WAF Developer Guide*.
    capacity: i64,

    /// The labels that one or more rules in this rule group match against in label
    /// match statements. These labels are defined in a `LabelMatchStatement`
    /// specification, in the Statement definition of a rule.
    consumed_labels: ?[]const LabelSummary = null,

    /// A map of custom response keys and content bodies. When you create a rule
    /// with a block action, you can send a custom response to the web request. You
    /// define these for the rule group, and then use them in the rules that you
    /// define in the rule group.
    ///
    /// For information about customizing web requests and responses,
    /// see [Customizing web requests and responses in
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-custom-request-response.html)
    /// in the *WAF Developer Guide*.
    ///
    /// For information about the limits on count and size for custom request and
    /// response settings, see [WAF
    /// quotas](https://docs.aws.amazon.com/waf/latest/developerguide/limits.html)
    /// in the *WAF Developer Guide*.
    custom_response_bodies: ?[]const aws.map.MapEntry(CustomResponseBody) = null,

    /// A description of the rule group that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the rule group. This ID is returned in the responses
    /// to create and list commands. You provide it to operations like update and
    /// delete.
    id: []const u8,

    /// The label namespace prefix for this rule group. All labels added by rules in
    /// this rule group have this prefix.
    ///
    /// * The syntax for the label namespace prefix for your rule groups is the
    ///   following:
    ///
    /// `awswaf::rulegroup::`
    ///
    /// * When a rule with a label matches a web request, WAF adds the fully
    ///   qualified label to the request. A fully qualified label is made up of the
    ///   label namespace from the rule group or web ACL where the rule is defined
    ///   and the label from the rule, separated by a colon:
    ///
    /// `:`
    label_namespace: ?[]const u8 = null,

    /// The name of the rule group. You cannot change the name of a rule group after
    /// you create it.
    name: []const u8,

    /// The Rule statements used to identify the web requests that you
    /// want to manage. Each rule includes one top-level statement that WAF uses to
    /// identify matching
    /// web requests, and parameters that govern how WAF handles them.
    rules: ?[]const Rule = null,

    /// Defines and enables Amazon CloudWatch metrics and web request sample
    /// collection.
    visibility_config: VisibilityConfig,

    pub const json_field_names = .{
        .arn = "ARN",
        .available_labels = "AvailableLabels",
        .capacity = "Capacity",
        .consumed_labels = "ConsumedLabels",
        .custom_response_bodies = "CustomResponseBodies",
        .description = "Description",
        .id = "Id",
        .label_namespace = "LabelNamespace",
        .name = "Name",
        .rules = "Rules",
        .visibility_config = "VisibilityConfig",
    };
};
