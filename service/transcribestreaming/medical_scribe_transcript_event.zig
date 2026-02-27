const MedicalScribeTranscriptSegment = @import("medical_scribe_transcript_segment.zig").MedicalScribeTranscriptSegment;

/// The event associated with `MedicalScribeResultStream`.
///
/// Contains `MedicalScribeTranscriptSegment`, which contains segment related
/// information.
pub const MedicalScribeTranscriptEvent = struct {
    /// The `TranscriptSegment` associated with a `MedicalScribeTranscriptEvent`.
    transcript_segment: ?MedicalScribeTranscriptSegment,

    pub const json_field_names = .{
        .transcript_segment = "TranscriptSegment",
    };
};
