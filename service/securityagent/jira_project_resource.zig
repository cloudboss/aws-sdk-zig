/// Represents a Jira project resource used in an integration.
pub const JiraProjectResource = struct {
    name: []const u8,

    /// The Jira project identifier.
    project_id: []const u8,

    /// The Jira project key, for example PROJ.
    project_key: []const u8,

    /// The display name of the Jira project.
    project_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .project_id = "projectId",
        .project_key = "projectKey",
        .project_name = "projectName",
    };
};
