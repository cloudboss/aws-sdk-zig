/// Configuration of the Jira integration.
pub const JiraConfiguration = struct {
    /// The URL of the associated Jira issue.
    jira_issue_url: ?[]const u8,

    last_synced_time: ?i64,

    pub const json_field_names = .{
        .jira_issue_url = "JiraIssueUrl",
        .last_synced_time = "LastSyncedTime",
    };
};
