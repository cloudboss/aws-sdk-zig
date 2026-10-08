/// The input required to create a GitHub integration, including the OAuth
/// authorization code and CSRF state.
pub const GitHubIntegrationInput = struct {
    /// The OAuth authorization code received from GitHub.
    code: []const u8,

    /// The installation identifier provided by GitHub Enterprise Server on the
    /// install callback. Required for GitHub Enterprise Server integrations and
    /// ignored for GitHub.com.
    installation_id: ?[]const u8 = null,

    /// The name of the GitHub organization to integrate with.
    organization_name: ?[]const u8 = null,

    /// The CSRF state token for validating the OAuth flow.
    state: []const u8,

    /// The HTTPS URL of a self-hosted GitHub Enterprise Server instance. Omit this
    /// value for GitHub.com.
    target_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .installation_id = "installationId",
        .organization_name = "organizationName",
        .state = "state",
        .target_url = "targetUrl",
    };
};
