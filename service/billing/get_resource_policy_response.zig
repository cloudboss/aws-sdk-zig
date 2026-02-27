pub const GetResourcePolicyResponse = struct {
    /// The resource-based policy document attached to the resource in `JSON`
    /// format.
    policy: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the billing view resource to which the
    /// policy is attached to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_arn = "resourceArn",
    };
};
