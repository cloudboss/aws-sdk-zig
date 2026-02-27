const Oauth2Discovery = @import("oauth_2_discovery.zig").Oauth2Discovery;

/// The configuration details returned for a supported OAuth2 provider,
/// including client credentials and OAuth2 discovery information.
pub const IncludedOauth2ProviderConfigOutput = struct {
    /// The client ID for the supported OAuth2 provider.
    client_id: ?[]const u8,

    oauth_discovery: Oauth2Discovery,

    pub const json_field_names = .{
        .client_id = "clientId",
        .oauth_discovery = "oauthDiscovery",
    };
};
