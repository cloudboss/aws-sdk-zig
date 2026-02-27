/// Configuration settings for connecting to LinkedIn services using OAuth2
/// authentication. This includes the client credentials required to
/// authenticate with LinkedIn's OAuth2 authorization server.
pub const LinkedinOauth2ProviderConfigInput = struct {
    /// The client ID for the LinkedIn OAuth2 provider. This identifier is assigned
    /// by LinkedIn when you register your application.
    client_id: []const u8,

    /// The client secret for the LinkedIn OAuth2 provider. This secret is assigned
    /// by LinkedIn and used along with the client ID to authenticate your
    /// application.
    client_secret: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .client_secret = "clientSecret",
    };
};
