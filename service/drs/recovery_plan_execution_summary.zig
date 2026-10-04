const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const RecoveryPlanExecutionMode = @import("recovery_plan_execution_mode.zig").RecoveryPlanExecutionMode;
const RecoveryPlanExecutionStatus = @import("recovery_plan_execution_status.zig").RecoveryPlanExecutionStatus;

/// Summary information about a Recovery Plan execution.
pub const RecoveryPlanExecutionSummary = struct {
    /// Error details if the execution failed.
    error_detail: ?ErrorDetail = null,

    /// The execution mode.
    mode: RecoveryPlanExecutionMode,

    /// The ARN of the Recovery Plan.
    recovery_plan_arn: []const u8,

    /// The ARN of the Recovery Plan execution.
    recovery_plan_execution_arn: []const u8,

    /// The timestamp when the execution started.
    started_at: []const u8,

    /// The execution status.
    status: RecoveryPlanExecutionStatus,

    pub const json_field_names = .{
        .error_detail = "errorDetail",
        .mode = "mode",
        .recovery_plan_arn = "recoveryPlanArn",
        .recovery_plan_execution_arn = "recoveryPlanExecutionArn",
        .started_at = "startedAt",
        .status = "status",
    };
};
