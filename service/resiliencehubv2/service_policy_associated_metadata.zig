const PolicyValueSource = @import("policy_value_source.zig").PolicyValueSource;

/// Metadata for a service policy associated event.
pub const ServicePolicyAssociatedMetadata = struct {
    policy_arn: ?[]const u8 = null,

    /// The name of the associated policy.
    policy_name: ?[]const u8 = null,

    /// The account that owns the policy.
    policy_owner_account_id: ?[]const u8 = null,

    /// The source of the policy.
    ///
    /// * SELF — the policy belongs to the account that owns the service.
    /// * CROSS_ACCOUNT — the policy belongs to another account and was shared with
    ///   the organization.
    policy_source: ?PolicyValueSource = null,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .policy_name = "policyName",
        .policy_owner_account_id = "policyOwnerAccountId",
        .policy_source = "policySource",
    };
};
