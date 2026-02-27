const SpeakerSearchResult = @import("speaker_search_result.zig").SpeakerSearchResult;

/// The details of a speaker search task.
pub const SpeakerSearchDetails = struct {
    /// The result value in the speaker search details.
    results: ?[]const SpeakerSearchResult,

    /// The status of a voice print generation operation,
    /// `VoiceprintGenerationSuccess` or `VoiceprintGenerationFailure`..
    voiceprint_generation_status: ?[]const u8,

    pub const json_field_names = .{
        .results = "Results",
        .voiceprint_generation_status = "VoiceprintGenerationStatus",
    };
};
