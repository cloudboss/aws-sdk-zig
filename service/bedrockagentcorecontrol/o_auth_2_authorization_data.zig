/// OAuth2-specific authorization data, including the authorization URL and user
/// identifier for the authorization session.
pub const OAuth2AuthorizationData = struct {
    /// The URL to initiate the authorization process. This URL is provided when the
    /// OAuth2 access token requires user authorization.
    authorization_url: []const u8,

    /// The user identifier associated with the OAuth2 authorization session that is
    /// defined by AgentCore Gateway.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .user_id = "userId",
    };
};
