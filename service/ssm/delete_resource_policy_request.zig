pub const DeleteResourcePolicyRequest = struct {
    /// ID of the current policy version. The hash helps to prevent multiple calls
    /// from attempting
    /// to overwrite a policy.
    policy_hash: []const u8,

    /// The policy ID.
    policy_id: []const u8,

    /// Amazon Resource Name (ARN) of the resource to which the policies are
    /// attached.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
        .resource_arn = "ResourceArn",
    };
};
