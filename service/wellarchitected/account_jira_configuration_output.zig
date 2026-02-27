const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const AccountJiraIssueManagementStatus = @import("account_jira_issue_management_status.zig").AccountJiraIssueManagementStatus;
const IssueManagementType = @import("issue_management_type.zig").IssueManagementType;

/// Account-level: Output configuration of the Jira integration.
pub const AccountJiraConfigurationOutput = struct {
    /// Account-level: Configuration status of the Jira integration.
    integration_status: ?IntegrationStatus,

    /// Account-level: Jira issue management status.
    issue_management_status: ?AccountJiraIssueManagementStatus,

    /// Account-level: Jira issue management type.
    issue_management_type: ?IssueManagementType,

    /// Account-level: Jira project key to sync workloads to.
    jira_project_key: ?[]const u8,

    /// Account-level: Status message on configuration of the Jira integration.
    status_message: ?[]const u8,

    /// Account-level: Jira subdomain URL.
    subdomain: ?[]const u8,

    pub const json_field_names = .{
        .integration_status = "IntegrationStatus",
        .issue_management_status = "IssueManagementStatus",
        .issue_management_type = "IssueManagementType",
        .jira_project_key = "JiraProjectKey",
        .status_message = "StatusMessage",
        .subdomain = "Subdomain",
    };
};
