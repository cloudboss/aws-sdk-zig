/// Authentication configuration for accessing a private git repository.
pub const HarnessSkillGitAuth = struct {
    /// The ARN of the credential in AgentCore Identity containing the password or
    /// personal access token.
    credential_arn: []const u8,

    /// Username for authentication. Defaults to 'oauth2' if not specified.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .credential_arn = "credentialArn",
        .username = "username",
    };
};
