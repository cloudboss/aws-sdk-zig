const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;

/// The configuration details returned for a LinkedIn OAuth2 provider, including
/// the client ID and OAuth2 discovery information.
pub const LinkedinOauth2ProviderConfigOutput = struct {
    /// The client ID for the LinkedIn OAuth2 provider.
    client_id: ?[]const u8 = null,

    oauth_discovery: Oauth2Discovery,

    pub const json_field_names = .{
        .client_id = "clientId",
        .oauth_discovery = "oauthDiscovery",
    };
};
