const MedicalScribeTranscriptSegment = @import("medical_scribe_transcript_segment.zig").MedicalScribeTranscriptSegment;

/// An event containing transcript data from the Medical Scribe stream
pub const MedicalScribeTranscriptEvent = struct {
    /// A segment of the transcript
    transcript_segment: ?MedicalScribeTranscriptSegment = null,

    pub const json_field_names = .{
        .transcript_segment = "transcriptSegment",
    };
};
