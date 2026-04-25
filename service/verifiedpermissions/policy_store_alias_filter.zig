/// Contains filters for the `ListPolicyStoreAliases` operation.
pub const PolicyStoreAliasFilter = struct {
    /// The ID of the policy store to filter by. Only policy store aliases
    /// associated with this policy store are returned.
    policy_store_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_store_id = "policyStoreId",
    };
};
