/// Information for a single version of a managed rule set.
///
/// This is intended for use only by vendors of managed rule sets. Vendors are
/// Amazon Web Services and Amazon Web Services Marketplace sellers.
///
/// Vendors, you can use the managed rule set APIs to provide controlled rollout
/// of your versioned managed rule group offerings for your customers. The APIs
/// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
/// and `UpdateManagedRuleSetVersionExpiryDate`.
pub const ManagedRuleSetVersion = struct {
    /// The Amazon Resource Name (ARN) of the vendor rule group that's used to
    /// define the
    /// published version of your managed rule group.
    associated_rule_group_arn: ?[]const u8 = null,

    /// The web ACL capacity units (WCUs) required for this rule group.
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
    capacity: ?i64 = null,

    /// The time that this version is set to expire.
    ///
    /// Times are in Coordinated Universal Time (UTC) format. UTC format includes
    /// the special designator, Z. For example, "2016-09-27T14:50Z".
    expiry_timestamp: ?i64 = null,

    /// The amount of time you expect this version of your managed rule group to
    /// last, in days.
    forecasted_lifetime: ?i32 = null,

    /// The last time that you updated this version.
    ///
    /// Times are in Coordinated Universal Time (UTC) format. UTC format includes
    /// the special designator, Z. For example, "2016-09-27T14:50Z".
    last_update_timestamp: ?i64 = null,

    /// The time that you first published this version.
    ///
    /// Times are in Coordinated Universal Time (UTC) format. UTC format includes
    /// the special designator, Z. For example, "2016-09-27T14:50Z".
    publish_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .associated_rule_group_arn = "AssociatedRuleGroupArn",
        .capacity = "Capacity",
        .expiry_timestamp = "ExpiryTimestamp",
        .forecasted_lifetime = "ForecastedLifetime",
        .last_update_timestamp = "LastUpdateTimestamp",
        .publish_timestamp = "PublishTimestamp",
    };
};
