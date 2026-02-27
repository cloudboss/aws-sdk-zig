const ExecutionState = @import("execution_state.zig").ExecutionState;

/// The status of the execution.
pub const ExecutionStatus = struct {
    /// The current state of the computation model.
    state: ExecutionState,

    pub const json_field_names = .{
        .state = "state",
    };
};
