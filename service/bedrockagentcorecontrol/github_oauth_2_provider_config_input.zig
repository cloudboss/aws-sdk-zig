/// Input configuration for a GitHub OAuth2 provider.
pub const GithubOauth2ProviderConfigInput = struct {
    /// The client ID for the GitHub OAuth2 provider.
    client_id: []const u8,

    /// The client secret for the GitHub OAuth2 provider.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
