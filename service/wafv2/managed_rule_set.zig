const aws = @import("aws");

const ManagedRuleSetVersion = @import("managed_rule_set_version.zig").ManagedRuleSetVersion;

/// A set of rules that is managed by Amazon Web Services and Amazon Web
/// Services Marketplace sellers to provide versioned managed
/// rule groups for customers of WAF.
///
/// This is intended for use only by vendors of managed rule sets. Vendors are
/// Amazon Web Services and Amazon Web Services Marketplace sellers.
///
/// Vendors, you can use the managed rule set APIs to provide controlled rollout
/// of your versioned managed rule group offerings for your customers. The APIs
/// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
/// and `UpdateManagedRuleSetVersionExpiryDate`.
pub const ManagedRuleSet = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: []const u8,

    /// A description of the set that helps with identification.
    description: ?[]const u8,

    /// A unique identifier for the managed rule set. The ID is returned in the
    /// responses to commands like `list`. You provide it to operations like `get`
    /// and `update`.
    id: []const u8,

    /// The label namespace prefix for the managed rule groups that are offered to
    /// customers from this managed rule set. All labels that are added by rules in
    /// the managed rule group have this prefix.
    ///
    /// * The syntax for the label namespace prefix for a managed rule group is the
    ///   following:
    ///
    /// `awswaf:managed::`:
    ///
    /// * When a rule with a label matches a web request, WAF adds the fully
    ///   qualified label to the request. A fully qualified label is made up of the
    ///   label namespace from the rule group or web ACL where the rule is defined
    ///   and the label from the rule, separated by a colon:
    ///
    /// `:`
    label_namespace: ?[]const u8,

    /// The name of the managed rule set. You use this, along with the rule set ID,
    /// to identify the rule set.
    ///
    /// This name is assigned to the corresponding managed rule group, which your
    /// customers can access and use.
    name: []const u8,

    /// The versions of this managed rule set that are available for use by
    /// customers.
    published_versions: ?[]const aws.map.MapEntry(ManagedRuleSetVersion),

    /// The version that you would like your customers to use.
    recommended_version: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .id = "Id",
        .label_namespace = "LabelNamespace",
        .name = "Name",
        .published_versions = "PublishedVersions",
        .recommended_version = "RecommendedVersion",
    };
};
