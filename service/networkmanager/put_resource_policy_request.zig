pub const PutResourcePolicyRequest = struct {
    /// The JSON resource policy document.
    policy_document: []const u8,

    /// The ARN of the resource policy.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy_document = "PolicyDocument",
        .resource_arn = "ResourceArn",
    };
};
