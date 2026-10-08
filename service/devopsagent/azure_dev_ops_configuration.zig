/// Configuration for Azure DevOps project integration.
pub const AzureDevOpsConfiguration = struct {
    /// Azure DevOps organization name.
    organization_name: []const u8,

    /// Azure DevOps project ID.
    project_id: []const u8,

    /// Azure DevOps project name.
    project_name: []const u8,

    pub const json_field_names = .{
        .organization_name = "organizationName",
        .project_id = "projectId",
        .project_name = "projectName",
    };
};
