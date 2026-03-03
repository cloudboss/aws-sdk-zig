const RealTimeContactAnalysisCharacterInterval = @import("real_time_contact_analysis_character_interval.zig").RealTimeContactAnalysisCharacterInterval;

/// Transcript representation containing Id and list of character intervals that
/// are associated with analysis data.
/// For example, this object within a `RealTimeContactAnalysisPointOfInterest`
/// in
/// `Category.MatchedDetails` would have character interval describing part of
/// the text that matched
/// category.
pub const RealTimeContactAnalysisTranscriptItemWithCharacterOffsets = struct {
    /// List of character intervals within transcript content/text.
    character_offsets: ?RealTimeContactAnalysisCharacterInterval = null,

    /// Transcript identifier. Matches the identifier from one of the
    /// TranscriptSegments.
    id: []const u8,

    pub const json_field_names = .{
        .character_offsets = "CharacterOffsets",
        .id = "Id",
    };
};
