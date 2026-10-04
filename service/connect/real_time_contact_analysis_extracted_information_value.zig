const RealTimeContactAnalysisTranscriptItemWithCharacterOffsets = @import("real_time_contact_analysis_transcript_item_with_character_offsets.zig").RealTimeContactAnalysisTranscriptItemWithCharacterOffsets;

/// An individual value extracted from the conversation, including its content
/// and the locations where it
/// was found.
pub const RealTimeContactAnalysisExtractedInformationValue = struct {
    /// The text content of the extracted value.
    content: []const u8,

    /// The sections in the conversation that indicate where the extracted value was
    /// found.
    points_of_interest: []const RealTimeContactAnalysisTranscriptItemWithCharacterOffsets,

    pub const json_field_names = .{
        .content = "Content",
        .points_of_interest = "PointsOfInterest",
    };
};
