/// Contains details required to create an integration with a self-managed
/// GitLab
/// instance.
pub const CreateGitLabSelfManagedIntegrationDetail = struct {
    /// The personal access token used to authenticate with the self-managed GitLab
    /// instance.
    access_token: []const u8,

    /// The URL of the self-managed GitLab instance.
    instance_url: []const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .instance_url = "instanceUrl",
    };
};
