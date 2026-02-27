const ParticipantTimerConfiguration = @import("participant_timer_configuration.zig").ParticipantTimerConfiguration;

/// Configuration information for the chat participant role.
pub const ChatParticipantRoleConfig = struct {
    /// A list of participant timers. You can specify any unique combination of role
    /// and timer type. Duplicate entries
    /// error out the request with a 400.
    participant_timer_config_list: []const ParticipantTimerConfiguration,

    pub const json_field_names = .{
        .participant_timer_config_list = "ParticipantTimerConfigList",
    };
};
