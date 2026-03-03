/// Statistics for an OpenSearch Serverless access policy.
pub const AccessPolicyStats = struct {
    /// The number of data access policies in the current account.
    data_policy_count: ?i64 = null,

    pub const json_field_names = .{
        .data_policy_count = "DataPolicyCount",
    };
};
