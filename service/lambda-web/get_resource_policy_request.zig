/// The request to retrieve a resource-based policy.
pub const GetResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the web function.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
