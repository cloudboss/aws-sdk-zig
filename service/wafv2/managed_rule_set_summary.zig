/// High-level information for a managed rule set.
///
/// This is intended for use only by vendors of managed rule sets. Vendors are
/// Amazon Web Services and Amazon Web Services Marketplace sellers.
///
/// Vendors, you can use the managed rule set APIs to provide controlled rollout
/// of your versioned managed rule group offerings for your customers. The APIs
/// are `ListManagedRuleSets`, `GetManagedRuleSet`, `PutManagedRuleSetVersions`,
/// and `UpdateManagedRuleSetVersionExpiryDate`.
pub const ManagedRuleSetSummary = struct {
    /// The Amazon Resource Name (ARN) of the entity.
    arn: ?[]const u8 = null,

    /// A description of the set that helps with identification.
    description: ?[]const u8 = null,

    /// A unique identifier for the managed rule set. The ID is returned in the
    /// responses to commands like `list`. You provide it to operations like `get`
    /// and `update`.
    id: ?[]const u8 = null,

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
    label_namespace: ?[]const u8 = null,

    /// A token used for optimistic locking. WAF returns a token to your `get` and
    /// `list` requests, to mark the state of the entity at the time of the request.
    /// To make changes to the entity associated with the token, you provide the
    /// token to operations like `update` and `delete`. WAF uses the token to ensure
    /// that no changes have been made to the entity since you last retrieved it. If
    /// a change has been made, the update fails with a
    /// `WAFOptimisticLockException`. If this happens, perform another `get`, and
    /// use the new token returned by that operation.
    lock_token: ?[]const u8 = null,

    /// The name of the managed rule set. You use this, along with the rule set ID,
    /// to identify the rule set.
    ///
    /// This name is assigned to the corresponding managed rule group, which your
    /// customers can access and use.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .id = "Id",
        .label_namespace = "LabelNamespace",
        .lock_token = "LockToken",
        .name = "Name",
    };
};
