/// Metadata for a system policy disassociated event.
pub const SystemPolicyDisassociatedMetadata = struct {
    policy_arn: ?[]const u8 = null,

    /// The name of the disassociated policy.
    policy_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
        .policy_name = "policyName",
    };
};
