const CreateGitLabSelfManagedIntegrationDetail = @import("create_git_lab_self_managed_integration_detail.zig").CreateGitLabSelfManagedIntegrationDetail;

/// Contains details required to create a code security integration with a
/// specific
/// repository provider.
pub const CreateIntegrationDetail = union(enum) {
    /// Details specific to creating an integration with a self-managed GitLab
    /// instance.
    gitlab_self_managed: ?CreateGitLabSelfManagedIntegrationDetail,

    pub const json_field_names = .{
        .gitlab_self_managed = "gitlabSelfManaged",
    };
};
