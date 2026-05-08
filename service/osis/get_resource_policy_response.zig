pub const GetResourcePolicyResponse = struct {
    /// The resource-based policy document in JSON format.
    policy: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
