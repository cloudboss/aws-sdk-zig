const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const DataSourceSyncJobMetrics = @import("data_source_sync_job_metrics.zig").DataSourceSyncJobMetrics;
const DataSourceSyncJobStatus = @import("data_source_sync_job_status.zig").DataSourceSyncJobStatus;

/// Provides information about an Amazon Q Business data source connector
/// synchronization job.
pub const DataSourceSyncJob = struct {
    /// If the reason that the synchronization failed is due to an error with the
    /// underlying data source, this field contains a code that identifies the
    /// error.
    data_source_error_code: ?[]const u8,

    /// The Unix timestamp when the synchronization job completed.
    end_time: ?i64,

    /// If the `Status` field is set to `FAILED`, the `ErrorCode` field indicates
    /// the reason the synchronization failed.
    @"error": ?ErrorDetail,

    /// The identifier of a data source synchronization job.
    execution_id: ?[]const u8,

    /// Maps a batch delete document request to a specific data source sync job.
    /// This is optional and should only be supplied when documents are deleted by a
    /// data source connector.
    metrics: ?DataSourceSyncJobMetrics,

    /// The Unix time stamp when the data source synchronization job started.
    start_time: ?i64,

    /// The status of the synchronization job. When the `Status` field is set to
    /// `SUCCEEDED`, the synchronization job is done. If the status code is
    /// `FAILED`, the `ErrorCode` and `ErrorMessage` fields give you the reason for
    /// the failure.
    status: ?DataSourceSyncJobStatus,

    pub const json_field_names = .{
        .data_source_error_code = "dataSourceErrorCode",
        .end_time = "endTime",
        .@"error" = "error",
        .execution_id = "executionId",
        .metrics = "metrics",
        .start_time = "startTime",
        .status = "status",
    };
};
