/// Capabilities for an integrated Jira project.
pub const JiraResourceCapabilities = struct {
    /// Whether to post comments on issues in the integrated jira project.
    comment_issue: ?bool = null,

    /// Whether to create issues in the integrated jira project.
    create_issue: ?bool = null,

    pub const json_field_names = .{
        .comment_issue = "commentIssue",
        .create_issue = "createIssue",
    };
};
