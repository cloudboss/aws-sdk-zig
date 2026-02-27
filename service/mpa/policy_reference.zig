/// Contains the Amazon Resource Name (ARN) for a policy. Policies define what
/// operations a team that define the permissions for team resources.
pub const PolicyReference = struct {
    /// Amazon Resource Name (ARN) for the policy.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .policy_arn = "PolicyArn",
    };
};
