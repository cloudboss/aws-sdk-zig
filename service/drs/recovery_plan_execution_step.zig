const RecoveryPlanExecutionStepConfiguration = @import("recovery_plan_execution_step_configuration.zig").RecoveryPlanExecutionStepConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const RecoveryPlanExecutionStepStatus = @import("recovery_plan_execution_step_status.zig").RecoveryPlanExecutionStepStatus;

/// A Recovery Plan Execution Step resource.
pub const RecoveryPlanExecutionStep = struct {
    /// The number of times this step has been attempted.
    attempt: i32,

    configuration: RecoveryPlanExecutionStepConfiguration,

    /// The timestamp when the execution step was created.
    created_at: []const u8,

    /// Error details if the step failed.
    error_detail: ?ErrorDetail = null,

    /// The ARN of the execution step.
    recovery_plan_execution_step_arn: []const u8,

    /// The status of the execution step.
    status: RecoveryPlanExecutionStepStatus,

    step_index: i32,

    step_name: []const u8,

    /// The timestamp when the execution step was last updated.
    updated_at: []const u8,

    pub const json_field_names = .{
        .attempt = "attempt",
        .configuration = "configuration",
        .created_at = "createdAt",
        .error_detail = "errorDetail",
        .recovery_plan_execution_step_arn = "recoveryPlanExecutionStepArn",
        .status = "status",
        .step_index = "stepIndex",
        .step_name = "stepName",
        .updated_at = "updatedAt",
    };
};
