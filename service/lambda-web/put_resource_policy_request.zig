/// The request to add or update a resource-based policy.
pub const PutResourcePolicyRequest = struct {
    /// The JSON-formatted resource-based policy to attach to the web function.
    policy: []const u8,

    /// The Amazon Resource Name (ARN) of the web function.
    resource_arn: []const u8,

    /// The revision ID of the existing policy. Use this to prevent conflicts when
    /// updating a policy concurrently. If you don't specify a value, the update
    /// proceeds without checking the current revision.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_arn = "resourceArn",
        .revision_id = "revisionId",
    };
};
