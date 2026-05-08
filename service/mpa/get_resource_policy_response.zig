const PolicyType = @import("policy_type.zig").PolicyType;

pub const GetResourcePolicyResponse = struct {
    /// Document that contains the contents for the policy.
    policy_document: []const u8,

    /// Name of the policy.
    policy_name: []const u8,

    /// The type of policy
    policy_type: PolicyType,

    /// Amazon Resource Name (ARN) for the policy version.
    policy_version_arn: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) for the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy_document = "PolicyDocument",
        .policy_name = "PolicyName",
        .policy_type = "PolicyType",
        .policy_version_arn = "PolicyVersionArn",
        .resource_arn = "ResourceArn",
    };
};
