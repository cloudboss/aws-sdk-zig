/// A warning about a potential issue with a deployment.
pub const DeploymentWarningEntry = struct {
    /// A code that identifies the type of warning.
    code: []const u8,

    /// A human-readable description of the warning.
    message: []const u8,

    /// The ARN of the policy that the warning relates to.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
        .policy_arn = "policyArn",
    };
};
