const StatefulRuleGroupOverride = @import("stateful_rule_group_override.zig").StatefulRuleGroupOverride;

/// Identifier for a single stateful rule group, used in a firewall policy to
/// refer to a
/// rule group.
pub const StatefulRuleGroupReference = struct {
    /// Network Firewall plans to augment the active threat defense managed rule
    /// group with an additional deep threat inspection capability. When this
    /// capability is released, Amazon Web Services will analyze service logs of
    /// network traffic processed by these rule groups to identify threat indicators
    /// across customers.
    /// Amazon Web Services will use these threat indicators to improve the active
    /// threat defense managed rule groups and protect the security of Amazon Web
    /// Services customers and services.
    ///
    /// Customers can opt-out of deep threat inspection at any time through the
    /// Network Firewall console or API. When customers opt out, Network Firewall
    /// will not use the network traffic processed by those customers' active threat
    /// defense rule groups for rule group improvement.
    deep_threat_inspection: ?bool,

    /// The action that allows the policy owner to override the behavior of the rule
    /// group within a policy.
    override: ?StatefulRuleGroupOverride,

    /// An integer setting that indicates the order in which to run the stateful
    /// rule groups in
    /// a single FirewallPolicy. This setting only applies to firewall policies
    /// that specify the `STRICT_ORDER` rule order in the stateful engine options
    /// settings.
    ///
    /// Network Firewall evalutes each stateful rule group
    /// against a packet starting with the group that has the lowest priority
    /// setting. You must ensure
    /// that the priority settings are unique within each policy.
    ///
    /// You can change the priority settings of your rule groups at any time. To
    /// make it easier to
    /// insert rule groups later, number them so there's a wide range in between,
    /// for example use 100,
    /// 200, and so on.
    priority: ?i32,

    /// The Amazon Resource Name (ARN) of the stateful rule group.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .deep_threat_inspection = "DeepThreatInspection",
        .override = "Override",
        .priority = "Priority",
        .resource_arn = "ResourceArn",
    };
};
