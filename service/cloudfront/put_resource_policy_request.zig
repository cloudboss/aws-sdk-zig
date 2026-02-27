pub const PutResourcePolicyRequest = struct {
    /// The JSON-formatted resource policy to create.
    policy_document: []const u8,

    /// The Amazon Resource Name (ARN) of the CloudFront resource for which the
    /// policy is being created.
    resource_arn: []const u8,
};
