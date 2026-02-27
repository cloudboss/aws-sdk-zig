pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the entity resource that is associated
    /// with the
    /// resource policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
    };
};
