pub const GetResourcePolicyResult = struct {
    /// The resource policy in JSON format.
    policy_document: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the CloudFront resource that is associated
    /// with the resource policy.
    resource_arn: ?[]const u8 = null,
};
