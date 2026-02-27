const Transcript = @import("transcript.zig").Transcript;

/// The `TranscriptEvent` associated with a
/// `TranscriptResultStream`.
///
/// Contains a set of transcription results from one or more audio segments,
/// along with additional
/// information per your request parameters.
pub const TranscriptEvent = struct {
    /// Contains `Results`, which contains a set of transcription results from one
    /// or
    /// more audio segments, along with additional information per your request
    /// parameters. This can
    /// include information relating to alternative transcriptions, channel
    /// identification, partial
    /// result stabilization, language identification, and other
    /// transcription-related data.
    transcript: ?Transcript,

    pub const json_field_names = .{
        .transcript = "Transcript",
    };
};
