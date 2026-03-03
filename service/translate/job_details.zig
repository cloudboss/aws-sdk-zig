/// The number of documents successfully and unsuccessfully processed during a
/// translation
/// job.
pub const JobDetails = struct {
    /// The number of documents that could not be processed during a translation
    /// job.
    documents_with_errors_count: ?i32 = null,

    /// The number of documents used as input in a translation job.
    input_documents_count: ?i32 = null,

    /// The number of documents successfully processed during a translation job.
    translated_documents_count: ?i32 = null,

    pub const json_field_names = .{
        .documents_with_errors_count = "DocumentsWithErrorsCount",
        .input_documents_count = "InputDocumentsCount",
        .translated_documents_count = "TranslatedDocumentsCount",
    };
};
