/// Configuration for creating a new workspace when attaching a data source to
/// an OpenSearch application. The workspace is created after the data source is
/// successfully attached.
pub const WorkspaceConfigurationInput = struct {
    /// The name of the workspace to create. Must be between 1 and 40 characters and
    /// can contain alphanumeric characters, parentheses, brackets, hyphens,
    /// underscores, and spaces.
    name: []const u8,

    /// The type of workspace to create, which determines the use-case features
    /// enabled for the workspace. Valid values are `OBSERVABILITY`,
    /// `SECURITY_ANALYTICS`, and `SEARCH`.
    workspace_type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .workspace_type = "workspaceType",
    };
};
