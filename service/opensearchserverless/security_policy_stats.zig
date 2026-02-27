/// Statistics for an OpenSearch Serverless security policy.
pub const SecurityPolicyStats = struct {
    /// The number of encryption policies in the current account.
    encryption_policy_count: ?i64,

    /// The number of network policies in the current account.
    network_policy_count: ?i64,

    pub const json_field_names = .{
        .encryption_policy_count = "EncryptionPolicyCount",
        .network_policy_count = "NetworkPolicyCount",
    };
};
