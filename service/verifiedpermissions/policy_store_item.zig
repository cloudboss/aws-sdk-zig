/// Contains information about a policy store.
///
/// This data type is used as a response parameter for the
/// [ListPolicyStores](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicyStores.html) operation.
pub const PolicyStoreItem = struct {
    /// The Amazon Resource Name (ARN) of the policy store.
    arn: []const u8,

    /// The date and time the policy was created.
    created_date: i64,

    /// Descriptive text that you can provide to help with identification of the
    /// current policy store.
    description: ?[]const u8,

    /// The date and time the policy store was most recently updated.
    last_updated_date: ?i64,

    /// The unique identifier of the policy store.
    policy_store_id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_date = "createdDate",
        .description = "description",
        .last_updated_date = "lastUpdatedDate",
        .policy_store_id = "policyStoreId",
    };
};
