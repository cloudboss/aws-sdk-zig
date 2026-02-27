/// Information about the OAuth 2.0 authentication credential/token used to
/// configure a plugin.
pub const OAuth2ClientCredentialConfiguration = struct {
    /// The redirect URL required by the OAuth 2.0 protocol for Amazon Q Business to
    /// authenticate a plugin user through a third party authentication server.
    authorization_url: ?[]const u8,

    /// The ARN of an IAM role used by Amazon Q Business to access the OAuth 2.0
    /// authentication credentials stored in a Secrets Manager secret.
    role_arn: []const u8,

    /// The ARN of the Secrets Manager secret that stores the OAuth 2.0
    /// credentials/token used for plugin configuration.
    secret_arn: []const u8,

    /// The URL required by the OAuth 2.0 protocol to exchange an end user
    /// authorization code for an access token.
    token_url: ?[]const u8,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .role_arn = "roleArn",
        .secret_arn = "secretArn",
        .token_url = "tokenUrl",
    };
};
