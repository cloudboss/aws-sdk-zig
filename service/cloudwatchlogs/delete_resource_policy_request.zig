pub const DeleteResourcePolicyRequest = struct {
    /// The expected revision ID of the resource policy. Required when deleting a
    /// resource-scoped
    /// policy to prevent concurrent modifications.
    expected_revision_id: ?[]const u8,

    /// The name of the policy to be revoked. This parameter is required.
    policy_name: ?[]const u8,

    /// The ARN of the CloudWatch Logs resource for which the resource policy needs
    /// to be
    /// deleted
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .expected_revision_id = "expectedRevisionId",
        .policy_name = "policyName",
        .resource_arn = "resourceArn",
    };
};
