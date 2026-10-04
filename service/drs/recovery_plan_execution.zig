const aws = @import("aws");

const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const RecoveryPlanExecutionMode = @import("recovery_plan_execution_mode.zig").RecoveryPlanExecutionMode;
const RecoveryPlanExecutionStatus = @import("recovery_plan_execution_status.zig").RecoveryPlanExecutionStatus;

/// A Recovery Plan execution.
pub const RecoveryPlanExecution = struct {
    /// The timestamp when the execution completed.
    completed_at: ?[]const u8 = null,

    /// Error details if the execution failed.
    error_detail: ?ErrorDetail = null,

    /// The execution mode.
    mode: RecoveryPlanExecutionMode,

    /// The ARN of the Recovery Plan being executed.
    recovery_plan_arn: []const u8,

    /// The ARN of the Recovery Plan execution.
    recovery_plan_execution_arn: []const u8,

    /// The timestamp when the execution started.
    started_at: []const u8,

    /// The execution status.
    status: RecoveryPlanExecutionStatus,

    /// The tags associated with the Recovery Plan execution.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .error_detail = "errorDetail",
        .mode = "mode",
        .recovery_plan_arn = "recoveryPlanArn",
        .recovery_plan_execution_arn = "recoveryPlanExecutionArn",
        .started_at = "startedAt",
        .status = "status",
        .tags = "tags",
    };
};
