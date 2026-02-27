pub const DeleteResourcePolicyRequest = struct {
    /// Amazon Resource Name (ARN) of the resource from which the policy will be
    /// removed.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
