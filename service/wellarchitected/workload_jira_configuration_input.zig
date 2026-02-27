const WorkloadIssueManagementStatus = @import("workload_issue_management_status.zig").WorkloadIssueManagementStatus;
const IssueManagementType = @import("issue_management_type.zig").IssueManagementType;

/// Workload-level: Input for the Jira configuration.
pub const WorkloadJiraConfigurationInput = struct {
    /// Workload-level: Jira issue management status.
    issue_management_status: ?WorkloadIssueManagementStatus,

    /// Workload-level: Jira issue management type.
    issue_management_type: ?IssueManagementType,

    /// Workload-level: Jira project key to sync workloads to.
    jira_project_key: ?[]const u8,

    pub const json_field_names = .{
        .issue_management_status = "IssueManagementStatus",
        .issue_management_type = "IssueManagementType",
        .jira_project_key = "JiraProjectKey",
    };
};
