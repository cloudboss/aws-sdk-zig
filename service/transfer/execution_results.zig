const ExecutionStepResult = @import("execution_step_result.zig").ExecutionStepResult;

/// Specifies the steps in the workflow, as well as the steps to execute in case
/// of any errors during workflow execution.
pub const ExecutionResults = struct {
    /// Specifies the steps (actions) to take if errors are encountered during
    /// execution of the workflow.
    on_exception_steps: ?[]const ExecutionStepResult = null,

    /// Specifies the details for the steps that are in the specified workflow.
    steps: ?[]const ExecutionStepResult = null,

    pub const json_field_names = .{
        .on_exception_steps = "OnExceptionSteps",
        .steps = "Steps",
    };
};
