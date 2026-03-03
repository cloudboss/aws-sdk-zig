const RealTimeContactAnalysisCharacterInterval = @import("real_time_contact_analysis_character_interval.zig").RealTimeContactAnalysisCharacterInterval;

/// Object describing redaction applied to the segment.
pub const RealTimeContactAnalysisTranscriptItemRedaction = struct {
    /// List of character intervals each describing a part of the text that was
    /// redacted. For
    /// `OutputType.Raw`, part of the original text that contains data that can be
    /// redacted. For `
    /// OutputType.Redacted`, part of the string with redaction tag.
    character_offsets: ?[]const RealTimeContactAnalysisCharacterInterval = null,

    pub const json_field_names = .{
        .character_offsets = "CharacterOffsets",
    };
};
