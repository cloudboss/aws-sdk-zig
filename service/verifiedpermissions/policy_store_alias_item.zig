const AliasState = @import("alias_state.zig").AliasState;

/// Contains information about a policy store alias.
///
/// This data type is used as a response parameter for the
/// [ListPolicyStoreAliases](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyStoreAliases.html) operation.
pub const PolicyStoreAliasItem = struct {
    /// The Amazon Resource Name (ARN) of the policy store alias.
    alias_arn: []const u8,

    /// The name of the policy store alias.
    alias_name: []const u8,

    /// The date and time the policy store alias was created.
    created_at: i64,

    /// The ID of the policy store associated with the alias.
    policy_store_id: []const u8,

    /// The state of the policy store alias. Policy Store Aliases in the Active
    /// state can be used normally. When a policy store alias is deleted, it enters
    /// the PendingDeletion state. Policy Store Aliases in the PendingDeletion state
    /// cannot be used, and creating a policy store alias with the same alias name
    /// will fail.
    state: AliasState,

    pub const json_field_names = .{
        .alias_arn = "aliasArn",
        .alias_name = "aliasName",
        .created_at = "createdAt",
        .policy_store_id = "policyStoreId",
        .state = "state",
    };
};
