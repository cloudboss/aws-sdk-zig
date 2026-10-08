const MedicalScribeParticipantRole = @import("medical_scribe_participant_role.zig").MedicalScribeParticipantRole;

/// Defines a channel in the audio stream
pub const MedicalScribeChannelDefinition = struct {
    /// The channel identifier
    channel_id: i32,

    /// The role of the participant on this channel
    participant_role: MedicalScribeParticipantRole,

    pub const json_field_names = .{
        .channel_id = "channelId",
        .participant_role = "participantRole",
    };
};
