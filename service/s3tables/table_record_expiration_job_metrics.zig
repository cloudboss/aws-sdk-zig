/// Provides metrics for the record expiration job that most recently ran for a
/// table. The metrics provide insight into the amount of data that was removed
/// when the job ran.
pub const TableRecordExpirationJobMetrics = struct {
    /// The total number of data files that were removed when the job ran.
    deleted_data_files: ?i64,

    /// The total number of records that were removed when the job ran.
    deleted_records: ?i64,

    /// The total size (in bytes) of the data files that were removed when the job
    /// ran.
    removed_files_size: ?i64,

    pub const json_field_names = .{
        .deleted_data_files = "deletedDataFiles",
        .deleted_records = "deletedRecords",
        .removed_files_size = "removedFilesSize",
    };
};
