/// Configuration settings for connecting to Atlassian services using OAuth2
/// authentication. This includes the client credentials required to
/// authenticate with Atlassian's OAuth2 authorization server.
pub const AtlassianOauth2ProviderConfigInput = struct {
    /// The client ID for the Atlassian OAuth2 provider. This identifier is assigned
    /// by Atlassian when you register your application.
    client_id: []const u8,

    /// The client secret for the Atlassian OAuth2 provider. This secret is assigned
    /// by Atlassian and used along with the client ID to authenticate your
    /// application.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
