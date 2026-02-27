const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains details for a policy. Policies define what operations a team that
/// define the permissions for team resources.
pub const Policy = struct {
    /// Amazon Resource Name (ARN) for the policy.
    arn: []const u8,

    /// Determines if the specified policy is the default for the team.
    default_version: i32,

    /// Name of the policy.
    name: []const u8,

    /// The type of policy.
    policy_type: PolicyType,

    pub const json_field_names = .{
        .arn = "Arn",
        .default_version = "DefaultVersion",
        .name = "Name",
        .policy_type = "PolicyType",
    };
};
