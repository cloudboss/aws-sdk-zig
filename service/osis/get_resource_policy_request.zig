pub const GetResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource for which to retrieve the
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
