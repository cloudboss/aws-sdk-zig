/// Relevant metrics on input records processed during bulk deployment.
pub const BulkDeploymentMetrics = struct {
    /// The total number of records that returned a non-retryable error. For
    /// example, this can occur if a group record from the input file uses an
    /// invalid format or specifies a nonexistent group version, or if the execution
    /// role doesn't grant permission to deploy a group or group version.
    invalid_input_records: ?i32 = null,

    /// The total number of group records from the input file that have been
    /// processed so far, or attempted.
    records_processed: ?i32 = null,

    /// The total number of deployment attempts that returned a retryable error. For
    /// example, a retry is triggered if the attempt to deploy a group returns a
    /// throttling error. ''StartBulkDeployment'' retries a group deployment up to
    /// five times.
    retry_attempts: ?i32 = null,

    pub const json_field_names = .{
        .invalid_input_records = "InvalidInputRecords",
        .records_processed = "RecordsProcessed",
        .retry_attempts = "RetryAttempts",
    };
};
