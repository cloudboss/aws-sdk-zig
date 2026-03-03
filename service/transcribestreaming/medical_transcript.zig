const MedicalResult = @import("medical_result.zig").MedicalResult;

/// The `MedicalTranscript` associated with a
/// ``.
///
/// `MedicalTranscript` contains `Results`, which contains a set of
/// transcription results from one or more audio segments, along with additional
/// information per your
/// request parameters.
pub const MedicalTranscript = struct {
    /// Contains a set of transcription results from one or more audio segments,
    /// along with
    /// additional information per your request parameters. This can include
    /// information relating to
    /// alternative transcriptions, channel identification, partial result
    /// stabilization, language
    /// identification, and other transcription-related data.
    results: ?[]const MedicalResult = null,

    pub const json_field_names = .{
        .results = "Results",
    };
};
