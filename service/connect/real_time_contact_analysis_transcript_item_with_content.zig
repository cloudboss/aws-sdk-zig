const RealTimeContactAnalysisCharacterInterval = @import("real_time_contact_analysis_character_interval.zig").RealTimeContactAnalysisCharacterInterval;

/// Transcript representation containing Id, Content and list of character
/// intervals that are associated with
/// analysis data. For example, this object within an issue detected would
/// describe both content that contains identified
/// issue and intervals where that content is taken from.
pub const RealTimeContactAnalysisTranscriptItemWithContent = struct {
    character_offsets: ?RealTimeContactAnalysisCharacterInterval,

    /// Part of the transcript content that contains identified issue. Can be
    /// redacted
    content: ?[]const u8,

    /// Transcript identifier. Matches the identifier from one of the
    /// TranscriptSegments.
    id: []const u8,

    pub const json_field_names = .{
        .character_offsets = "CharacterOffsets",
        .content = "Content",
        .id = "Id",
    };
};
