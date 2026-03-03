/// The result of a speaker search analysis.
pub const SpeakerSearchResult = struct {
    /// The confidence score in the speaker search analysis.
    confidence_score: f32 = 0,

    /// The voice profile ID.
    voice_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence_score = "ConfidenceScore",
        .voice_profile_id = "VoiceProfileId",
    };
};
