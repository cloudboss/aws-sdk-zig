const MedicalScribeParticipantRole = @import("medical_scribe_participant_role.zig").MedicalScribeParticipantRole;

/// Makes it possible to specify which speaker is on which channel.
/// For example, if the clinician is the first participant to speak, you would
/// set the `ChannelId` of the first
/// `ChannelDefinition`
/// in the list to `0` (to indicate the first channel) and `ParticipantRole` to
/// `CLINICIAN`
/// (to indicate that it's the clinician speaking).
/// Then you would set the `ChannelId` of the second `ChannelDefinition` in the
/// list to
/// `1`
/// (to indicate the second channel) and `ParticipantRole` to `PATIENT` (to
/// indicate that it's the patient speaking).
///
/// If you don't specify a channel definition, HealthScribe will diarize the
/// transcription and identify speaker roles for each speaker.
pub const MedicalScribeChannelDefinition = struct {
    /// Specify the audio channel you want to define.
    channel_id: i32 = 0,

    /// Specify the participant that you want to flag.
    /// The allowed options are `CLINICIAN` and
    /// `PATIENT`.
    participant_role: MedicalScribeParticipantRole,

    pub const json_field_names = .{
        .channel_id = "ChannelId",
        .participant_role = "ParticipantRole",
    };
};
