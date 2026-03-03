/// An error entity for assessment report evidence errors. This is used to
/// provide more
/// meaningful errors than a simple string message.
pub const AssessmentReportEvidenceError = struct {
    /// The error code that was returned.
    error_code: ?[]const u8 = null,

    /// The error message that was returned.
    error_message: ?[]const u8 = null,

    /// The identifier for the evidence.
    evidence_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .evidence_id = "evidenceId",
    };
};
