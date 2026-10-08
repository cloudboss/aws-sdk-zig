/// Metadata for a system policy associated event.
pub const SystemPolicyAssociatedMetadata = struct {
    policy_arn: ?[]const u8 = null,

    /// The name of the associated policy.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .policy_name = "policyName",
    };
};
