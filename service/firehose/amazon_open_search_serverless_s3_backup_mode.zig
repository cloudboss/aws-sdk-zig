pub const AmazonOpenSearchServerlessS3BackupMode = enum {
    failed_documents_only,
    all_documents,

    pub const json_field_names = .{
        .failed_documents_only = "FailedDocumentsOnly",
        .all_documents = "AllDocuments",
    };
};
