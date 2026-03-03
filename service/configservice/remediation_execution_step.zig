const RemediationExecutionStepState = @import("remediation_execution_step_state.zig").RemediationExecutionStepState;

/// Name of the step from the SSM document.
pub const RemediationExecutionStep = struct {
    /// An error message if the step was interrupted during execution.
    error_message: ?[]const u8 = null,

    /// The details of the step.
    name: ?[]const u8 = null,

    /// The time when the step started.
    start_time: ?i64 = null,

    /// The valid status of the step.
    state: ?RemediationExecutionStepState = null,

    /// The time when the step stopped.
    stop_time: ?i64 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .name = "Name",
        .start_time = "StartTime",
        .state = "State",
        .stop_time = "StopTime",
    };
};
