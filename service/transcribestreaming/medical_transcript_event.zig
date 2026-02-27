const MedicalTranscript = @import("medical_transcript.zig").MedicalTranscript;

/// The `MedicalTranscriptEvent` associated with a
/// `MedicalTranscriptResultStream`.
///
/// Contains a set of transcription results from one or more audio segments,
/// along with additional
/// information per your request parameters.
pub const MedicalTranscriptEvent = struct {
    /// Contains `Results`, which contains a set of transcription results from one
    /// or
    /// more audio segments, along with additional information per your request
    /// parameters. This can
    /// include information relating to alternative transcriptions, channel
    /// identification, partial result
    /// stabilization, language identification, and other transcription-related
    /// data.
    transcript: ?MedicalTranscript,

    pub const json_field_names = .{
        .transcript = "Transcript",
    };
};
