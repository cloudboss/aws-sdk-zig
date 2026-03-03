/// Used by select connectors for which the OAuth workflow is supported, such as
/// Salesforce,
/// Google Analytics, Marketo, Zendesk, and Slack.
pub const ConnectorOAuthRequest = struct {
    /// The code provided by the connector when it has been authenticated via the
    /// connected app.
    auth_code: ?[]const u8 = null,

    /// The URL to which the authentication server redirects the browser after
    /// authorization has
    /// been granted.
    redirect_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_code = "authCode",
        .redirect_uri = "redirectUri",
    };
};
