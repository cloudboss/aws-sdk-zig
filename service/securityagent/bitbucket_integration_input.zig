/// The configuration for creating a Bitbucket integration.
pub const BitbucketIntegrationInput = struct {
    /// The OAuth 2.0 authorization code returned from the consent redirect.
    code: []const u8,

    /// The Atlassian installation identifier, available from the Atlassian
    /// administration console.
    installation_id: []const u8,

    /// The CSRF state token echoed back from the OAuth redirect.
    state: []const u8,

    /// The Bitbucket workspace slug that identifies the workspace to integrate, for
    /// example acme-corp.
    workspace: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .installation_id = "installationId",
        .state = "state",
        .workspace = "workspace",
    };
};
