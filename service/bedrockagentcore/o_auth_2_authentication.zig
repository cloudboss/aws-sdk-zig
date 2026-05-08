/// OAuth2 authentication information for third-party providers.
/// Supports Google, Apple, X, Telegram, and GitHub providers.
pub const OAuth2Authentication = struct {
    /// The email address from the OAuth2 provider (optional).
    email_address: ?[]const u8 = null,

    /// The user's name from the OAuth2 provider (optional).
    name: ?[]const u8 = null,

    /// The subject (sub) claim from the OAuth2 provider.
    /// Uniquely identifies the user at the provider.
    sub: []const u8,

    /// The username from the OAuth2 provider (optional).
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_address = "emailAddress",
        .name = "name",
        .sub = "sub",
        .username = "username",
    };
};
