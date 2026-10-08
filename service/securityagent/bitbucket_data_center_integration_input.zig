/// Connection details for a self-managed Bitbucket Data Center integration.
pub const BitbucketDataCenterIntegrationInput = struct {
    /// The OAuth 2.0 authorization code returned to your redirect URL after the
    /// connection is authorized.
    code: []const u8,

    /// The CSRF state value returned by `InitiateProviderRegistration` and echoed
    /// back on the authorization redirect.
    state: []const u8,

    /// The HTTPS URL of your Bitbucket Data Center instance, for example
    /// `https://bitbucket.example.com`.
    target_url: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .state = "state",
        .target_url = "targetUrl",
    };
};
