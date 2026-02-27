const ProactiveRefreshTokenRenewal = @import("proactive_refresh_token_renewal.zig").ProactiveRefreshTokenRenewal;
const TokenEndpointAuthenticationScheme = @import("token_endpoint_authentication_scheme.zig").TokenEndpointAuthenticationScheme;

/// Configuration details for OAuth authentication with a third-party service.
pub const OAuthConfig = struct {
    /// The authorization URL for the OAuth service, where users are directed to
    /// authenticate and authorize access.
    auth_url: []const u8,

    /// The URL where users are redirected after completing the OAuth authorization
    /// process.
    o_auth_complete_redirect_url: ?[]const u8,

    /// Configuration for proactively refreshing OAuth tokens before they expire.
    proactive_refresh_token_renewal: ?ProactiveRefreshTokenRenewal,

    /// The OAuth scopes requested during authorization, which define the
    /// permissions granted to the application.
    scope: ?[]const u8,

    /// The authentication scheme used when requesting tokens from the token
    /// endpoint.
    token_endpoint_authentication_scheme: TokenEndpointAuthenticationScheme,

    /// The token URL for the OAuth service, where authorization codes are exchanged
    /// for access tokens.
    token_url: []const u8,

    pub const json_field_names = .{
        .auth_url = "authUrl",
        .o_auth_complete_redirect_url = "oAuthCompleteRedirectUrl",
        .proactive_refresh_token_renewal = "proactiveRefreshTokenRenewal",
        .scope = "scope",
        .token_endpoint_authentication_scheme = "tokenEndpointAuthenticationScheme",
        .token_url = "tokenUrl",
    };
};
