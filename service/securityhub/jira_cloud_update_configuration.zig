/// The parameters used to modify an existing Jira Cloud integration.
pub const JiraCloudUpdateConfiguration = struct {
    /// The project key for a JiraCloud instance.
    project_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_key = "ProjectKey",
    };
};
