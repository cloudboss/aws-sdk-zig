const RemediationExecutionStepState = @import("remediation_execution_step_state.zig").RemediationExecutionStepState;

/// Name of the step from the SSM document.
pub const RemediationExecutionStep = struct {
    /// An error message if the step was interrupted during execution.
    error_message: ?[]const u8,

    /// The details of the step.
    name: ?[]const u8,

    /// The time when the step started.
    start_time: ?i64,

    /// The valid status of the step.
    state: ?RemediationExecutionStepState,

    /// The time when the step stopped.
    stop_time: ?i64,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .name = "Name",
        .start_time = "StartTime",
        .state = "State",
        .stop_time = "StopTime",
    };
};
