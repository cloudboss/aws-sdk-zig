pub const PutResourcePolicyRequest = struct {
    /// The JSON formatted resource-based policy to attach.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the End User Messaging SMS resource to
    /// attach the resource-based policy to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "Policy",
        .resource_arn = "ResourceArn",
    };
};
