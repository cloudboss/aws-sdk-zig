const ParticipantRole = @import("participant_role.zig").ParticipantRole;

/// Makes it possible to specify which speaker is on which channel. For example,
/// if your
/// agent is the first participant to speak, you would set `ChannelId` to
/// `0` (to indicate the first channel) and `ParticipantRole` to
/// `AGENT` (to indicate that it's the agent speaking).
pub const ChannelDefinition = struct {
    /// Specify the audio channel you want to define.
    channel_id: i32 = 0,

    /// Specify the speaker you want to define. Omitting this parameter is
    /// equivalent to
    /// specifying both participants.
    participant_role: ?ParticipantRole = null,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .participant_role = "ParticipantRole",
    };
};
