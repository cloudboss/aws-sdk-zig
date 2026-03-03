const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;

/// Output configuration for a Google OAuth2 provider.
pub const GoogleOauth2ProviderConfigOutput = struct {
    /// The client ID for the Google OAuth2 provider.
    client_id: ?[]const u8 = null,

    /// The OAuth2 discovery information for the Google provider.
    oauth_discovery: Oauth2Discovery,

    pub const json_field_names = .{
        .client_id = "clientId",
        .oauth_discovery = "oauthDiscovery",
    };
};
