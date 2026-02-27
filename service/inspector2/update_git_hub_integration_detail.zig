/// Contains details required to update an integration with GitHub.
pub const UpdateGitHubIntegrationDetail = struct {
    /// The authorization code received from GitHub to update the integration.
    code: []const u8,

    /// The installation ID of the GitHub App associated with the integration.
    installation_id: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .installation_id = "installationId",
    };
};
