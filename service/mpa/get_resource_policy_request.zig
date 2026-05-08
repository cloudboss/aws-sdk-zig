const PolicyType = @import("policy_type.zig").PolicyType;

pub const GetResourcePolicyRequest = struct {
    /// Name of the policy.
    policy_name: []const u8,

    /// The type of policy.
    policy_type: PolicyType,

    /// Amazon Resource Name (ARN) for the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy_name = "PolicyName",
        .policy_type = "PolicyType",
        .resource_arn = "ResourceArn",
    };
};
