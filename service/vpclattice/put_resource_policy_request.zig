pub const PutResourcePolicyRequest = struct {
    /// An IAM policy. The policy string in JSON must not contain newlines or blank
    /// lines.
    policy: []const u8,

    /// The ID or ARN of the service network or service for which the policy is
    /// created.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .policy = "policy",
        .resource_arn = "resourceArn",
    };
};
