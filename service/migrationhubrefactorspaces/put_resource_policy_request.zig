pub const PutResourcePolicyRequest = struct {
    /// A JSON-formatted string for an Amazon Web Services resource-based policy.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the resource to which the policy is being
    /// attached.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
