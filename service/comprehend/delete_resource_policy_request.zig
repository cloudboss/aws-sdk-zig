pub const DeleteResourcePolicyRequest = struct {
    /// The revision ID of the policy to delete.
    policy_revision_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the custom model version that has the
    /// policy to delete.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy_revision_id = "PolicyRevisionId",
        .resource_arn = "ResourceArn",
    };
};
