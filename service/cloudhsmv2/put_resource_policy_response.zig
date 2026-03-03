pub const PutResourcePolicyResponse = struct {
    /// The policy attached to a resource.
    policy: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the resource to which a policy is attached.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
