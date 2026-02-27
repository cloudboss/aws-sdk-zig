/// Specifies the audio input specifications.
pub const AudioSpecification = struct {
    /// Time for which a bot waits after the customer stops speaking to assume the
    /// utterance is finished.
    end_timeout_ms: i32,

    /// Time for how long Amazon Lex waits before speech input is truncated and the
    /// speech
    /// is returned to application.
    max_length_ms: i32,

    pub const json_field_names = .{
        .end_timeout_ms = "endTimeoutMs",
        .max_length_ms = "maxLengthMs",
    };
};
