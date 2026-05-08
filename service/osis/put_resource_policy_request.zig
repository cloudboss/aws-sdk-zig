pub const PutResourcePolicyRequest = struct {
    /// The resource-based policy document in JSON format.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the resource to attach the policy to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
