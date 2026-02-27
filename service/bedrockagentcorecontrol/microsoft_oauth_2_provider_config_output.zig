const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;

/// Output configuration for a Microsoft OAuth2 provider.
pub const MicrosoftOauth2ProviderConfigOutput = struct {
    /// The client ID for the Microsoft OAuth2 provider.
    client_id: ?[]const u8,

    /// The OAuth2 discovery information for the Microsoft provider.
    oauth_discovery: Oauth2Discovery,

    pub const json_field_names = .{
        .client_id = "clientId",
        .oauth_discovery = "oauthDiscovery",
    };
};
