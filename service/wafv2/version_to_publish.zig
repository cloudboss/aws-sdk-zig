/// A version of the named managed rule group, that the rule group's vendor
/// publishes for
/// use by customers.
///
/// This is intended for use only by vendors of managed rule sets. Vendors are
/// Amazon Web Services and Amazon Web Services Marketplace sellers.
///
/// Vendors, you can use the managed rule set APIs to provide controlled rollout
/// of your versioned managed rule group offerings for your customers. The APIs
/// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
/// and `UpdateManagedRuleSetVersionExpiryDate`.
pub const VersionToPublish = struct {
    /// The Amazon Resource Name (ARN) of the vendor's rule group that's used in the
    /// published
    /// managed rule group version.
    associated_rule_group_arn: ?[]const u8,

    /// The amount of time the vendor expects this version of the managed rule group
    /// to last, in
    /// days.
    forecasted_lifetime: ?i32,

    pub const json_field_names = .{
        .associated_rule_group_arn = "AssociatedRuleGroupArn",
        .forecasted_lifetime = "ForecastedLifetime",
    };
};
