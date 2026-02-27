const IntegrationStatusInput = @import("integration_status_input.zig").IntegrationStatusInput;
const AccountJiraIssueManagementStatus = @import("account_jira_issue_management_status.zig").AccountJiraIssueManagementStatus;
const IssueManagementType = @import("issue_management_type.zig").IssueManagementType;

/// Account-level: Input for the Jira configuration.
pub const AccountJiraConfigurationInput = struct {
    /// Account-level: Configuration status of the Jira integration.
    integration_status: ?IntegrationStatusInput,

    /// Account-level: Jira issue management status.
    issue_management_status: ?AccountJiraIssueManagementStatus,

    /// Account-level: Jira issue management type.
    issue_management_type: ?IssueManagementType,

    /// Account-level: Jira project key to sync workloads to.
    jira_project_key: ?[]const u8,

    pub const json_field_names = .{
        .integration_status = "IntegrationStatus",
        .issue_management_status = "IssueManagementStatus",
        .issue_management_type = "IssueManagementType",
        .jira_project_key = "JiraProjectKey",
    };
};
