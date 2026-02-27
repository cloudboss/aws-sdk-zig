const MedicalScribeParticipantRole = @import("medical_scribe_participant_role.zig").MedicalScribeParticipantRole;

/// Indicates which speaker is on which channel. The options are
/// `CLINICIAN` and `PATIENT`
pub const MedicalScribeChannelDefinition = struct {
    /// Specify the audio channel you want to define.
    channel_id: i32 = 0,

    /// Specify the participant that you want to flag.
    /// The options are `CLINICIAN` and `PATIENT`
    participant_role: MedicalScribeParticipantRole,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .participant_role = "ParticipantRole",
    };
};
