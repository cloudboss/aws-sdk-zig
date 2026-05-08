pub const DeleteResourcePolicyRequest = struct {
    /// The ARN of the policy to delete.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
