/// The proposed access control configuration for a DynamoDB table or index. You
/// can propose a configuration for a new DynamoDB table or index or an existing
/// DynamoDB table or index that you own by specifying the policy for the
/// DynamoDB table or index. For more information, see
/// [PutResourcePolicy](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutResourcePolicy.html).
///
/// * If the configuration is for an existing DynamoDB table or index and you do
///   not specify the DynamoDB policy, then the access preview uses the existing
///   DynamoDB policy for the table or index.
/// * If the access preview is for a new resource and you do not specify the
///   policy, then the access preview assumes a DynamoDB table without a policy.
/// * To propose deletion of an existing DynamoDB table or index policy, you can
///   specify an empty string for the DynamoDB policy.
pub const DynamodbTableConfiguration = struct {
    /// The proposed resource policy defining who can access or manage the DynamoDB
    /// table.
    table_policy: ?[]const u8,

    pub const json_field_names = .{
        .table_policy = "tablePolicy",
    };
};
