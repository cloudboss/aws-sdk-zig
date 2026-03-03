const ImportDestination = @import("import_destination.zig").ImportDestination;
const JobStatus = @import("job_status.zig").JobStatus;

/// A summary of the import job.
pub const ImportJobSummary = struct {
    /// The date and time when the import job was created.
    created_timestamp: ?i64 = null,

    /// The number of records that failed processing because of invalid input or
    /// other
    /// reasons.
    failed_records_count: ?i32 = null,

    import_destination: ?ImportDestination = null,

    job_id: ?[]const u8 = null,

    job_status: ?JobStatus = null,

    /// The current number of records processed.
    processed_records_count: ?i32 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .failed_records_count = "FailedRecordsCount",
        .import_destination = "ImportDestination",
        .job_id = "JobId",
        .job_status = "JobStatus",
        .processed_records_count = "ProcessedRecordsCount",
    };
};
