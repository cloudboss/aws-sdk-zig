/// Input configuration for a Slack OAuth2 provider.
pub const SlackOauth2ProviderConfigInput = struct {
    /// The client ID for the Slack OAuth2 provider.
    client_id: []const u8,

    /// The client secret for the Slack OAuth2 provider.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
