pub const GetResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the End User Messaging SMS resource
    /// attached to the resource-based policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
