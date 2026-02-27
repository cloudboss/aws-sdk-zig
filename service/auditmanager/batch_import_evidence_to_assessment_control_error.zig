const ManualEvidence = @import("manual_evidence.zig").ManualEvidence;

/// An error entity for the `BatchImportEvidenceToAssessmentControl` API. This
/// is used to provide more meaningful errors than a simple string message.
pub const BatchImportEvidenceToAssessmentControlError = struct {
    /// The error code that the `BatchImportEvidenceToAssessmentControl` API
    /// returned.
    error_code: ?[]const u8,

    /// The error message that the `BatchImportEvidenceToAssessmentControl` API
    /// returned.
    error_message: ?[]const u8,

    /// Manual evidence that can't be collected automatically by Audit Manager.
    manual_evidence: ?ManualEvidence,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .manual_evidence = "manualEvidence",
    };
};
