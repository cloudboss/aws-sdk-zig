pub const PutResourcePolicyRequest = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token,
    /// Amazon Lookout for Equipment generates one.
    client_token: []const u8,

    /// A unique identifier for a revision of the resource policy.
    policy_revision_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the resource for which the policy is being
    /// created.
    resource_arn: []const u8,

    /// The JSON-formatted resource policy to create.
    resource_policy: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .policy_revision_id = "PolicyRevisionId",
        .resource_arn = "ResourceArn",
        .resource_policy = "ResourcePolicy",
    };
};
