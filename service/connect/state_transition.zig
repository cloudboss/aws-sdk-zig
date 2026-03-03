const ParticipantState = @import("participant_state.zig").ParticipantState;

/// Information about the state transition of a supervisor.
pub const StateTransition = struct {
    /// The state of the transition.
    state: ?ParticipantState = null,

    /// The date and time when the state ended in UTC time.
    state_end_timestamp: ?i64 = null,

    /// The date and time when the state started in UTC time.
    state_start_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .state = "State",
        .state_end_timestamp = "StateEndTimestamp",
        .state_start_timestamp = "StateStartTimestamp",
    };
};
