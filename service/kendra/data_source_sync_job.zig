const ErrorCode = @import("error_code.zig").ErrorCode;
const DataSourceSyncJobMetrics = @import("data_source_sync_job_metrics.zig").DataSourceSyncJobMetrics;
const DataSourceSyncJobStatus = @import("data_source_sync_job_status.zig").DataSourceSyncJobStatus;

/// Provides information about a data source synchronization job.
pub const DataSourceSyncJob = struct {
    /// If the reason that the synchronization failed is due to an error with the
    /// underlying data
    /// source, this field contains a code that identifies the error.
    data_source_error_code: ?[]const u8,

    /// The Unix timestamp when the synchronization job completed.
    end_time: ?i64,

    /// If the `Status` field is set to `FAILED`, the `ErrorCode`
    /// field indicates the reason the synchronization failed.
    error_code: ?ErrorCode,

    /// If the `Status` field is set to `ERROR`, the
    /// `ErrorMessage` field contains a description of the error that caused the
    /// synchronization to fail.
    error_message: ?[]const u8,

    /// A identifier for the synchronization job.
    execution_id: ?[]const u8,

    /// Maps a batch delete document request to a specific data source sync job.
    /// This is optional
    /// and should only be supplied when documents are deleted by a data source
    /// connector.
    metrics: ?DataSourceSyncJobMetrics,

    /// The Unix timestamp when the synchronization job started.
    start_time: ?i64,

    /// The execution status of the synchronization job. When the `Status` field is
    /// set
    /// to `SUCCEEDED`, the synchronization job is done. If the status code is set
    /// to
    /// `FAILED`, the `ErrorCode` and `ErrorMessage` fields give
    /// you the reason for the failure.
    status: ?DataSourceSyncJobStatus,

    pub const json_field_names = .{
        .data_source_error_code = "DataSourceErrorCode",
        .end_time = "EndTime",
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .execution_id = "ExecutionId",
        .metrics = "Metrics",
        .start_time = "StartTime",
        .status = "Status",
    };
};
