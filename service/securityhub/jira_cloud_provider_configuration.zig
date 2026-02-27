/// The initial configuration settings required to establish an integration
/// between Security Hub and Jira Cloud.
pub const JiraCloudProviderConfiguration = struct {
    /// The project key for a JiraCloud instance.
    project_key: ?[]const u8,

    pub const json_field_names = .{
        .project_key = "ProjectKey",
    };
};
