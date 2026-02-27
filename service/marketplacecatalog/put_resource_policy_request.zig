pub const PutResourcePolicyRequest = struct {
    /// The policy document to set; formatted in JSON.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the entity resource you want to associate
    /// with a
    /// resource policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
