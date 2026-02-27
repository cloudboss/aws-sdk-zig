/// Contains the statistics for the data ingestion job.
pub const IngestionJobStatistics = struct {
    /// The number of source documents that were deleted.
    number_of_documents_deleted: i64 = 0,

    /// The number of source documents that failed to be ingested.
    number_of_documents_failed: i64 = 0,

    /// The total number of source documents that were scanned. Includes new,
    /// updated, and unchanged documents.
    number_of_documents_scanned: i64 = 0,

    /// The number of metadata files that were updated or deleted.
    number_of_metadata_documents_modified: i64 = 0,

    /// The total number of metadata files that were scanned. Includes new, updated,
    /// and unchanged files.
    number_of_metadata_documents_scanned: i64 = 0,

    /// The number of modified source documents in the data source that were
    /// successfully indexed.
    number_of_modified_documents_indexed: i64 = 0,

    /// The number of new source documents in the data source that were successfully
    /// indexed.
    number_of_new_documents_indexed: i64 = 0,

    pub const json_field_names = .{
        .number_of_documents_deleted = "numberOfDocumentsDeleted",
        .number_of_documents_failed = "numberOfDocumentsFailed",
        .number_of_documents_scanned = "numberOfDocumentsScanned",
        .number_of_metadata_documents_modified = "numberOfMetadataDocumentsModified",
        .number_of_metadata_documents_scanned = "numberOfMetadataDocumentsScanned",
        .number_of_modified_documents_indexed = "numberOfModifiedDocumentsIndexed",
        .number_of_new_documents_indexed = "numberOfNewDocumentsIndexed",
    };
};
