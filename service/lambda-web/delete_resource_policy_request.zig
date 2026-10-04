/// The request to delete a resource-based policy.
pub const DeleteResourcePolicyRequest = struct {
    /// The Amazon Resource Name (ARN) of the web function.
    resource_arn: []const u8,

    /// The revision ID of the policy. Use this to prevent deleting a policy that
    /// has been updated since you last retrieved it. If you don't specify a value,
    /// the policy is deleted regardless of its current revision.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
        .revision_id = "revisionId",
    };
};
