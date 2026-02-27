const UpdateGitHubIntegrationDetail = @import("update_git_hub_integration_detail.zig").UpdateGitHubIntegrationDetail;
const UpdateGitLabSelfManagedIntegrationDetail = @import("update_git_lab_self_managed_integration_detail.zig").UpdateGitLabSelfManagedIntegrationDetail;

/// Contains details required to update a code security integration with a
/// specific
/// repository provider.
pub const UpdateIntegrationDetails = union(enum) {
    /// Details specific to updating an integration with GitHub.
    github: ?UpdateGitHubIntegrationDetail,
    /// Details specific to updating an integration with a self-managed GitLab
    /// instance.
    gitlab_self_managed: ?UpdateGitLabSelfManagedIntegrationDetail,

    pub const json_field_names = .{
        .github = "github",
        .gitlab_self_managed = "gitlabSelfManaged",
    };
};
