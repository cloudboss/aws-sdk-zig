pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the resource from which to delete the
    /// policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
