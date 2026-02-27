/// Details about the progress of a batch load task.
pub const BatchLoadProgressReport = struct {
    bytes_metered: i64 = 0,

    file_failures: i64 = 0,

    parse_failures: i64 = 0,

    record_ingestion_failures: i64 = 0,

    records_ingested: i64 = 0,

    records_processed: i64 = 0,

    pub const json_field_names = .{
        .bytes_metered = "BytesMetered",
        .file_failures = "FileFailures",
        .parse_failures = "ParseFailures",
        .record_ingestion_failures = "RecordIngestionFailures",
        .records_ingested = "RecordsIngested",
        .records_processed = "RecordsProcessed",
    };
};
