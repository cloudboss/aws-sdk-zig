pub const GetResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the billing view resource to which the
    /// policy is attached to.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};
