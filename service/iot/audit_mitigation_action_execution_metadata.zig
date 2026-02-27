const AuditMitigationActionsExecutionStatus = @import("audit_mitigation_actions_execution_status.zig").AuditMitigationActionsExecutionStatus;

/// Returned by ListAuditMitigationActionsTask, this object contains information
/// that describes a mitigation action that has been started.
pub const AuditMitigationActionExecutionMetadata = struct {
    /// The unique identifier for the mitigation action being applied by the task.
    action_id: ?[]const u8,

    /// The friendly name of the mitigation action being applied by the task.
    action_name: ?[]const u8,

    /// The date and time when the task was completed or canceled. Blank if the task
    /// is still running.
    end_time: ?i64,

    /// If an error occurred, the code that indicates which type of error occurred.
    error_code: ?[]const u8,

    /// The unique identifier for the findings to which the task and associated
    /// mitigation action are applied.
    finding_id: ?[]const u8,

    /// If an error occurred, a message that describes the error.
    message: ?[]const u8,

    /// The date and time when the task was started.
    start_time: ?i64,

    /// The current status of the task being executed.
    status: ?AuditMitigationActionsExecutionStatus,

    /// The unique identifier for the task that applies the mitigation action.
    task_id: ?[]const u8,

    pub const json_field_names = .{
        .action_id = "actionId",
        .action_name = "actionName",
        .end_time = "endTime",
        .error_code = "errorCode",
        .finding_id = "findingId",
        .message = "message",
        .start_time = "startTime",
        .status = "status",
        .task_id = "taskId",
    };
};
