const ProactiveRefreshTokenRenewal = @import("proactive_refresh_token_renewal.zig").ProactiveRefreshTokenRenewal;

/// Structure containing updated OAuth configuration settings.
pub const OAuthUpdate = struct {
    /// The updated URL where users are redirected after completing the OAuth
    /// authorization process.
    o_auth_complete_redirect_url: ?[]const u8 = null,

    /// Updated configuration for proactively refreshing OAuth tokens before they
    /// expire.
    proactive_refresh_token_renewal: ?ProactiveRefreshTokenRenewal = null,

    pub const json_field_names = .{
        .o_auth_complete_redirect_url = "oAuthCompleteRedirectUrl",
        .proactive_refresh_token_renewal = "proactiveRefreshTokenRenewal",
    };
};
