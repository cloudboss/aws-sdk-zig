/// Evidence that's manually added to a control in Audit Manager.
/// `manualEvidence` can be one of the following: `evidenceFileName`,
/// `s3ResourcePath`, or `textResponse`.
pub const ManualEvidence = struct {
    /// The name of the file that's uploaded as manual evidence. This name is
    /// populated using
    /// the `evidenceFileName` value from the [
    /// `GetEvidenceFileUploadUrl`
    /// ](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_GetEvidenceFileUploadUrl.html) API response.
    evidence_file_name: ?[]const u8 = null,

    /// The S3 URL of the object that's imported as manual evidence.
    s_3_resource_path: ?[]const u8 = null,

    /// The plain text response that's entered and saved as manual evidence.
    text_response: ?[]const u8 = null,

    pub const json_field_names = .{
        .evidence_file_name = "evidenceFileName",
        .s_3_resource_path = "s3ResourcePath",
        .text_response = "textResponse",
    };
};
