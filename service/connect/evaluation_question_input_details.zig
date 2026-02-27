const EvaluationTranscriptType = @import("evaluation_transcript_type.zig").EvaluationTranscriptType;

/// Details of the input data used for automated question processing.
pub const EvaluationQuestionInputDetails = struct {
    /// Transcript type.
    transcript_type: ?EvaluationTranscriptType,

    pub const json_field_names = .{
        .transcript_type = "TranscriptType",
    };
};
