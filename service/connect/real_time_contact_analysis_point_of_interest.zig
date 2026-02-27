const RealTimeContactAnalysisTranscriptItemWithCharacterOffsets = @import("real_time_contact_analysis_transcript_item_with_character_offsets.zig").RealTimeContactAnalysisTranscriptItemWithCharacterOffsets;

/// The section of the contact transcript segment that category rule was
/// detected.
pub const RealTimeContactAnalysisPointOfInterest = struct {
    /// List of the transcript items (segments) that are associated with a given
    /// point of interest.
    transcript_items: ?[]const RealTimeContactAnalysisTranscriptItemWithCharacterOffsets,

    pub const json_field_names = .{
        .transcript_items = "TranscriptItems",
    };
};
