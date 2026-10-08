const CodeRemediationTaskStatus = @import("code_remediation_task_status.zig").CodeRemediationTaskStatus;
const CodeRemediationTaskDetails = @import("code_remediation_task_details.zig").CodeRemediationTaskDetails;

/// Represents a code remediation task that was initiated to fix a security
/// finding.
pub const CodeRemediationTask = struct {
    /// The current status of the code remediation task.
    status: CodeRemediationTaskStatus,

    /// The reason for the current status of the code remediation task.
    status_reason: ?[]const u8 = null,

    /// The list of details for the code remediation task, including repository
    /// name, code diff link, and pull request link.
    task_details: ?[]const CodeRemediationTaskDetails = null,

    pub const json_field_names = .{
        .status = "status",
        .status_reason = "statusReason",
        .task_details = "taskDetails",
    };
};
