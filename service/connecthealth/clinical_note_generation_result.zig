const ArtifactDetails = @import("artifact_details.zig").ArtifactDetails;

/// Results of clinical note generation including note, transcript, and summary
pub const ClinicalNoteGenerationResult = struct {
    /// Details about the generated after visit summary
    after_visit_summary_result: ?ArtifactDetails = null,

    /// Details about the generated clinical note
    note_result: ?ArtifactDetails = null,

    /// Details about the generated transcript
    transcript_result: ?ArtifactDetails = null,

    pub const json_field_names = .{
        .after_visit_summary_result = "afterVisitSummaryResult",
        .note_result = "noteResult",
        .transcript_result = "transcriptResult",
    };
};
