const ParticipantTimerAction = @import("participant_timer_action.zig").ParticipantTimerAction;

/// The value of the timer. Either the timer action (`Unset` to delete the
/// timer), or the duration of the
/// timer in minutes. Only one value can be set.
///
/// For more information about how chat timeouts work, see
/// [Set up chat timeouts for human
/// participants](https://docs.aws.amazon.com/connect/latest/adminguide/setup-chat-timeouts.html).
pub const ParticipantTimerValue = union(enum) {
    /// The timer action. Currently only one value is allowed: `Unset`. It deletes a
    /// timer.
    participant_timer_action: ?ParticipantTimerAction,
    /// The duration of a timer, in minutes.
    participant_timer_duration_in_minutes: ?i32,

    pub const json_field_names = .{
        .participant_timer_action = "ParticipantTimerAction",
        .participant_timer_duration_in_minutes = "ParticipantTimerDurationInMinutes",
    };
};
