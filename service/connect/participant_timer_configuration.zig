const TimerEligibleParticipantRoles = @import("timer_eligible_participant_roles.zig").TimerEligibleParticipantRoles;
const ParticipantTimerType = @import("participant_timer_type.zig").ParticipantTimerType;
const ParticipantTimerValue = @import("participant_timer_value.zig").ParticipantTimerValue;

/// Configuration information for the timer. After the timer configuration is
/// set, it persists for the duration of
/// the chat. It persists across new contacts in the chain, for example,
/// transfer contacts.
///
/// For more information about how chat timeouts work, see
/// [Set up chat timeouts for human
/// participants](https://docs.aws.amazon.com/connect/latest/adminguide/setup-chat-timeouts.html).
pub const ParticipantTimerConfiguration = struct {
    /// The role of the participant in the chat conversation.
    participant_role: TimerEligibleParticipantRoles,

    /// The type of timer. `IDLE` indicates the timer applies for considering a
    /// human chat participant as
    /// idle. `DISCONNECT_NONCUSTOMER` indicates the timer applies to automatically
    /// disconnecting a chat
    /// participant due to idleness.
    timer_type: ParticipantTimerType,

    /// The value of the timer. Either the timer action (Unset to delete the timer),
    /// or the duration of the timer in
    /// minutes. Only one value can be set.
    timer_value: ParticipantTimerValue,

    pub const json_field_names = .{
        .participant_role = "ParticipantRole",
        .timer_type = "TimerType",
        .timer_value = "TimerValue",
    };
};
