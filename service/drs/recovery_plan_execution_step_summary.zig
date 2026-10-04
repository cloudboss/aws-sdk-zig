const RecoveryPlanExecutionStepConfiguration = @import("recovery_plan_execution_step_configuration.zig").RecoveryPlanExecutionStepConfiguration;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const RecoveryPlanExecutionStepStatus = @import("recovery_plan_execution_step_status.zig").RecoveryPlanExecutionStepStatus;

/// Summary information about a Recovery Plan execution step.
pub const RecoveryPlanExecutionStepSummary = struct {
    configuration: RecoveryPlanExecutionStepConfiguration,

    /// Error details if the step failed.
    error_detail: ?ErrorDetail = null,

    /// The ARN of the execution step.
    recovery_plan_execution_step_arn: []const u8,

    /// The status of the execution step.
    status: RecoveryPlanExecutionStepStatus,

    step_index: i32,

    step_name: []const u8,

    pub const json_field_names = .{
        .configuration = "configuration",
        .error_detail = "errorDetail",
        .recovery_plan_execution_step_arn = "recoveryPlanExecutionStepArn",
        .status = "status",
        .step_index = "stepIndex",
        .step_name = "stepName",
    };
};
