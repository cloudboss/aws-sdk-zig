const StepExecutionStatusDetail = @import("step_execution_status_detail.zig").StepExecutionStatusDetail;
const StepConfig = @import("step_config.zig").StepConfig;

/// Combines the execution state and configuration of a step.
pub const StepDetail = struct {
    /// The description of the step status.
    execution_status_detail: StepExecutionStatusDetail,

    /// The step configuration.
    step_config: StepConfig,

    pub const json_field_names = .{
        .execution_status_detail = "ExecutionStatusDetail",
        .step_config = "StepConfig",
    };
};
