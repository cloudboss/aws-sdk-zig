const LexTranscriptFilter = @import("lex_transcript_filter.zig").LexTranscriptFilter;

/// The object representing the filter that Amazon Lex will use to select the
/// appropriate transcript.
pub const TranscriptFilter = struct {
    /// The object representing the filter that Amazon Lex will use to select the
    /// appropriate transcript when the transcript format is the Amazon Lex
    /// format.
    lex_transcript_filter: ?LexTranscriptFilter,

    pub const json_field_names = .{
        .lex_transcript_filter = "lexTranscriptFilter",
    };
};
