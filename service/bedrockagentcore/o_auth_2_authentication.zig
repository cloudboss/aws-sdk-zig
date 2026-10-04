/// OAuth2 authentication information for third-party providers.
pub const OAuth2Authentication = struct {
    /// The email address from the OAuth2 provider.
    email_address: ?[]const u8 = null,

    /// The user's name from the OAuth2 provider.
    name: ?[]const u8 = null,

    /// The subject (sub) claim from the OAuth2 provider. Uniquely identifies the
    /// user at the provider.
    sub: []const u8,

    /// The username from the OAuth2 provider.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .email_address = "emailAddress",
        .name = "name",
        .sub = "sub",
        .username = "username",
    };
};
