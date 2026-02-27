pub const DeleteResourcePolicyResponse = struct {
    /// The policy previously attached to the resource.
    policy: ?[]const u8,

    /// Amazon Resource Name (ARN) of the resource from which the policy was
    /// deleted.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
