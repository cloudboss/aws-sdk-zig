const OAuth2Authentication = @import("o_auth_2_authentication.zig").OAuth2Authentication;

/// Authentication method using OAuth2 providers.
/// Supports Google, Apple, X, Telegram, and GitHub providers.
pub const LinkedAccountOAuth2 = union(enum) {
    /// Apple OAuth2 authentication
    apple: ?OAuth2Authentication,
    /// GitHub OAuth2 authentication
    github: ?OAuth2Authentication,
    /// Google OAuth2 authentication
    google: ?OAuth2Authentication,
    /// Telegram OAuth2 authentication
    telegram: ?OAuth2Authentication,
    /// X (formerly Twitter) OAuth2 authentication
    x: ?OAuth2Authentication,

    pub const json_field_names = .{
        .apple = "apple",
        .github = "github",
        .google = "google",
        .telegram = "telegram",
        .x = "x",
    };
};
