pub const PutResourcePolicyRequest = struct {
    /// A policy you want to associate with a resource.
    policy: []const u8,

    /// ID of the current policy version. The hash helps to prevent a situation
    /// where multiple users
    /// attempt to overwrite a policy. You must provide this hash when updating or
    /// deleting a
    /// policy.
    policy_hash: ?[]const u8,

    /// The policy ID.
    policy_id: ?[]const u8,

    /// Amazon Resource Name (ARN) of the resource to which you want to attach a
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .policy_hash = "PolicyHash",
        .policy_id = "PolicyId",
        .resource_arn = "ResourceArn",
    };
};
