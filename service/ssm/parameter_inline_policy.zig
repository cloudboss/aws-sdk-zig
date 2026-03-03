/// One or more policies assigned to a parameter.
pub const ParameterInlinePolicy = struct {
    /// The status of the policy. Policies report the following statuses: Pending
    /// (the policy hasn't
    /// been enforced or applied yet), Finished (the policy was applied), Failed
    /// (the policy wasn't
    /// applied), or InProgress (the policy is being applied now).
    policy_status: ?[]const u8 = null,

    /// The JSON text of the policy.
    policy_text: ?[]const u8 = null,

    /// The type of policy. Parameter Store, a tool in Amazon Web Services Systems
    /// Manager, supports the following policy
    /// types: Expiration, ExpirationNotification, and NoChangeNotification.
    policy_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_status = "PolicyStatus",
        .policy_text = "PolicyText",
        .policy_type = "PolicyType",
    };
};
