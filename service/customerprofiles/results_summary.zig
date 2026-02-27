/// The summary of results for an upload job, including the number of updated,
/// created, and
/// failed records.
pub const ResultsSummary = struct {
    /// The number of records that were newly created during the upload job.
    created_records: ?i64,

    /// The number of records that failed to be processed during the upload job.
    failed_records: ?i64,

    /// The number of records that were updated during the upload job.
    updated_records: ?i64,

    pub const json_field_names = .{
        .created_records = "CreatedRecords",
        .failed_records = "FailedRecords",
        .updated_records = "UpdatedRecords",
    };
};
