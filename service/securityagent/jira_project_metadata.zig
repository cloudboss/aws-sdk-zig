/// Contains metadata about a Jira project that is integrated with the service.
pub const JiraProjectMetadata = struct {
    name: []const u8,

    /// The Jira project identifier.
    project_id: []const u8,

    /// The Jira project key, for example PROJ.
    project_key: []const u8,

    /// The display name of the Jira project.
    project_name: ?[]const u8 = null,

    provider_resource_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .project_id = "projectId",
        .project_key = "projectKey",
        .project_name = "projectName",
        .provider_resource_id = "providerResourceId",
    };
};
