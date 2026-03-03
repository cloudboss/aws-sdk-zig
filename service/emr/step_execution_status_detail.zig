const StepExecutionState = @import("step_execution_state.zig").StepExecutionState;

/// The execution state of a step.
pub const StepExecutionStatusDetail = struct {
    /// The creation date and time of the step.
    creation_date_time: i64,

    /// The completion date and time of the step.
    end_date_time: ?i64 = null,

    /// A description of the step's current state.
    last_state_change_reason: ?[]const u8 = null,

    /// The start date and time of the step.
    start_date_time: ?i64 = null,

    /// The state of the step.
    state: StepExecutionState,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .last_state_change_reason = "LastStateChangeReason",
        .start_date_time = "StartDateTime",
        .state = "State",
    };
};
