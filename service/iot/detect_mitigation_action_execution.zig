const DetectMitigationActionExecutionStatus = @import("detect_mitigation_action_execution_status.zig").DetectMitigationActionExecutionStatus;

/// Describes which mitigation actions should be executed.
pub const DetectMitigationActionExecution = struct {
    /// The friendly name that uniquely identifies the mitigation action.
    action_name: ?[]const u8 = null,

    /// The error code of a mitigation action.
    error_code: ?[]const u8 = null,

    /// The date a mitigation action ended.
    execution_end_date: ?i64 = null,

    /// The date a mitigation action was started.
    execution_start_date: ?i64 = null,

    /// The message of a mitigation action.
    message: ?[]const u8 = null,

    /// The status of a mitigation action.
    status: ?DetectMitigationActionExecutionStatus = null,

    /// The unique identifier of the task.
    task_id: ?[]const u8 = null,

    /// The name of the thing.
    thing_name: ?[]const u8 = null,

    /// The unique identifier of the violation.
    violation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_name = "actionName",
        .error_code = "errorCode",
        .execution_end_date = "executionEndDate",
        .execution_start_date = "executionStartDate",
        .message = "message",
        .status = "status",
        .task_id = "taskId",
        .thing_name = "thingName",
        .violation_id = "violationId",
    };
};
