/// Statistics for an OpenSearch Serverless lifecycle policy.
pub const LifecyclePolicyStats = struct {
    /// The number of retention lifecycle policies in the current account.
    retention_policy_count: ?i64 = null,

    pub const json_field_names = .{
        .retention_policy_count = "RetentionPolicyCount",
    };
};
