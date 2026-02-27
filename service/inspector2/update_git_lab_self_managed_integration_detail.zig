/// Contains details required to update an integration with a self-managed
/// GitLab
/// instance.
pub const UpdateGitLabSelfManagedIntegrationDetail = struct {
    /// The authorization code received from the self-managed GitLab instance to
    /// update the
    /// integration.
    auth_code: []const u8,

    pub const json_field_names = .{
        .auth_code = "authCode",
    };
};
