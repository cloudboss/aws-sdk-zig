const EvaluationSuggestedAnswerTranscriptMillisecondOffsets = @import("evaluation_suggested_answer_transcript_millisecond_offsets.zig").EvaluationSuggestedAnswerTranscriptMillisecondOffsets;

/// Information about the point of interest in transcript provided to
/// evaluation.
pub const EvaluationTranscriptPointOfInterest = struct {
    /// Offset in milliseconds from the beginning of transcript.
    millisecond_offsets: ?EvaluationSuggestedAnswerTranscriptMillisecondOffsets,

    /// Segment of transcript.
    transcript_segment: ?[]const u8,

    pub const json_field_names = .{
        .millisecond_offsets = "MillisecondOffsets",
        .transcript_segment = "TranscriptSegment",
    };
};
