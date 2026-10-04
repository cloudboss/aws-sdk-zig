const ExecutionServerStepConfiguration = @import("execution_server_step_configuration.zig").ExecutionServerStepConfiguration;
const WaitStepConfiguration = @import("wait_step_configuration.zig").WaitStepConfiguration;

/// Type-specific configuration for an execution step response.
/// Mirrors RecoveryPlanStepConfiguration but uses execution-enriched server
/// shapes.
pub const RecoveryPlanExecutionStepConfiguration = union(enum) {
    /// Configuration for a SERVER type step (with execution state like jobID).
    execution_server_step_configuration: ?ExecutionServerStepConfiguration,
    /// Configuration for a WAIT type step.
    wait_step_configuration: ?WaitStepConfiguration,

    pub const json_field_names = .{
        .execution_server_step_configuration = "executionServerStepConfiguration",
        .wait_step_configuration = "waitStepConfiguration",
    };
};
