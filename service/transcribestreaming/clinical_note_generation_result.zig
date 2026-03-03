const ClinicalNoteGenerationStatus = @import("clinical_note_generation_status.zig").ClinicalNoteGenerationStatus;

/// The details for clinical note generation,
/// including status, and output locations for clinical note and aggregated
/// transcript if the analytics completed,
/// or failure reason if the analytics failed.
pub const ClinicalNoteGenerationResult = struct {
    /// Holds the Amazon S3 URI for the output Clinical Note.
    clinical_note_output_location: ?[]const u8 = null,

    /// If `ClinicalNoteGenerationResult` is `FAILED`, information about why it
    /// failed.
    failure_reason: ?[]const u8 = null,

    /// The status of the clinical note generation.
    ///
    /// Possible Values:
    ///
    /// * `IN_PROGRESS`
    ///
    /// * `FAILED`
    ///
    /// * `COMPLETED`
    ///
    /// After audio streaming finishes, and you send a
    /// `MedicalScribeSessionControlEvent` event (with END_OF_SESSION as the Type),
    /// the status is set to `IN_PROGRESS`.
    /// If the status is `COMPLETED`, the analytics completed successfully, and you
    /// can find the
    /// results at the locations specified in `ClinicalNoteOutputLocation` and
    /// `TranscriptOutputLocation`.
    /// If the status is `FAILED`, `FailureReason` provides details about the
    /// failure.
    status: ?ClinicalNoteGenerationStatus = null,

    /// Holds the Amazon S3 URI for the output Transcript.
    transcript_output_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .clinical_note_output_location = "ClinicalNoteOutputLocation",
        .failure_reason = "FailureReason",
        .status = "Status",
        .transcript_output_location = "TranscriptOutputLocation",
    };
};
