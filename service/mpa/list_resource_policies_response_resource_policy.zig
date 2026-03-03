const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains details about a policy for a resource.
pub const ListResourcePoliciesResponseResourcePolicy = struct {
    /// Amazon Resource Name (ARN) for policy.
    policy_arn: ?[]const u8 = null,

    /// Name of the policy.
    policy_name: ?[]const u8 = null,

    /// The type of policy.
    policy_type: ?PolicyType = null,

    pub const json_field_names = .{
        .policy_arn = "PolicyArn",
        .policy_name = "PolicyName",
        .policy_type = "PolicyType",
    };
};
