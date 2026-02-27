/// The milliseconds offset for transcript reference in suggested answer.
pub const EvaluationSuggestedAnswerTranscriptMillisecondOffsets = struct {
    /// Offset in milliseconds from the beginning of the transcript.
    begin_offset_millis: i32 = 0,

    pub const json_field_names = .{
        .begin_offset_millis = "BeginOffsetMillis",
    };
};
