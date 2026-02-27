/// Information about a policy that you include in a `BatchGetPolicy` API
/// request.
pub const BatchGetPolicyInputItem = struct {
    /// The identifier of the policy you want information about.
    policy_id: []const u8,

    /// The identifier of the policy store where the policy you want information
    /// about is stored.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .policy_id = "policyId",
        .policy_store_id = "policyStoreId",
    };
};
