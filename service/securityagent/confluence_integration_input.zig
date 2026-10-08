/// The configuration for creating a Confluence integration.
pub const ConfluenceIntegrationInput = struct {
    /// The OAuth 2.0 authorization code returned from the consent redirect.
    code: []const u8,

    /// The Atlassian installation identifier, available from the Atlassian
    /// administration console.
    installation_id: []const u8,

    /// The Confluence Cloud site URL, for example https://mysite.atlassian.net.
    site_url: []const u8,

    /// The CSRF state token echoed back from the OAuth redirect.
    state: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .installation_id = "installationId",
        .site_url = "siteUrl",
        .state = "state",
    };
};
