/// The location of the output of your Medical Scribe job.
/// `ClinicalDocumentUri` holds the Amazon S3 URI for the Clinical Document
/// and `TranscriptFileUri` holds the Amazon S3 URI for the Transcript.
pub const MedicalScribeOutput = struct {
    /// Holds the Amazon S3 URI for the Clinical Document.
    clinical_document_uri: []const u8,

    /// Holds the Amazon S3 URI for the Transcript.
    transcript_file_uri: []const u8,

    pub const json_field_names = .{
        .clinical_document_uri = "ClinicalDocumentUri",
        .transcript_file_uri = "TranscriptFileUri",
    };
};
