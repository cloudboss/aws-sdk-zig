const ActionIdentifier = @import("action_identifier.zig").ActionIdentifier;
const PolicyDefinitionItem = @import("policy_definition_item.zig").PolicyDefinitionItem;
const PolicyEffect = @import("policy_effect.zig").PolicyEffect;
const PolicyType = @import("policy_type.zig").PolicyType;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// Contains information about a policy.
///
/// This data type is used as a response parameter for the
/// [ListPolicies](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicies.html) operation.
pub const PolicyItem = struct {
    /// The action that a policy permits or forbids. For example, `{"actions":
    /// [{"actionId": "ViewPhoto", "actionType": "PhotoFlash::Action"}, {"entityID":
    /// "SharePhoto", "entityType": "PhotoFlash::Action"}]}`.
    actions: ?[]const ActionIdentifier = null,

    /// The date and time the policy was created.
    created_date: i64,

    /// The policy definition of an item in the list of policies returned.
    definition: PolicyDefinitionItem,

    /// The effect of the decision that a policy returns to an authorization
    /// request. For example, `"effect": "Permit"`.
    effect: ?PolicyEffect = null,

    /// The date and time the policy was most recently updated.
    last_updated_date: i64,

    /// The name of the policy, if one was assigned when the policy was created or
    /// last updated.
    name: ?[]const u8 = null,

    /// The identifier of the policy you want information about.
    policy_id: []const u8,

    /// The identifier of the policy store where the policy you want information
    /// about is stored.
    policy_store_id: []const u8,

    /// The type of the policy. This is one of the following values:
    ///
    /// * `STATIC`
    /// * `TEMPLATE_LINKED`
    policy_type: PolicyType,

    /// The principal associated with the policy.
    principal: ?EntityIdentifier = null,

    /// The resource associated with the policy.
    resource: ?EntityIdentifier = null,

    pub const json_field_names = .{
        .actions = "actions",
        .created_date = "createdDate",
        .definition = "definition",
        .effect = "effect",
        .last_updated_date = "lastUpdatedDate",
        .name = "name",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
        .policy_type = "policyType",
        .principal = "principal",
        .resource = "resource",
    };
};
