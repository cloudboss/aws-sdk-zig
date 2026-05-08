pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the End User Messaging SMS resource you're
    /// deleting the resource-based policy from.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
