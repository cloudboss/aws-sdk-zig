const RecoveryPlanExecutionStepStatus = @import("recovery_plan_execution_step_status.zig").RecoveryPlanExecutionStepStatus;

/// Filters for listing Recovery Plan execution steps.
pub const ListRecoveryPlanExecutionStepsFilter = struct {
    /// Filter by execution step status.
    status: ?RecoveryPlanExecutionStepStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
