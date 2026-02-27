const PolicyDefinitionDetail = @import("policy_definition_detail.zig").PolicyDefinitionDetail;
const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains information about a policy returned from a `BatchGetPolicy` API
/// request.
pub const BatchGetPolicyOutputItem = struct {
    /// The date and time the policy was created.
    created_date: i64,

    /// The policy definition of an item in the list of policies returned.
    definition: PolicyDefinitionDetail,

    /// The date and time the policy was most recently updated.
    last_updated_date: i64,

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

    pub const json_field_names = .{
        .created_date = "createdDate",
        .definition = "definition",
        .last_updated_date = "lastUpdatedDate",
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
        .policy_type = "policyType",
    };
};
