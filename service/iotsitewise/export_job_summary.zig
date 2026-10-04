const DatasetExportJobStatus = @import("dataset_export_job_status.zig").DatasetExportJobStatus;

/// Contains summary information about a dataset export job.
pub const ExportJobSummary = struct {
    /// The timestamp when the job completed, or null if the job is still running.
    completed_at: ?i64 = null,

    /// The S3 URI where output clips are written.
    destination_s3_uri: []const u8,

    /// The unique identifier for the dataset export job.
    job_id: []const u8,

    /// The timestamp when the job started processing.
    started_at: i64,

    /// The current status of the dataset export job.
    status: DatasetExportJobStatus,

    pub const json_field_names = .{
        .completed_at = "completedAt",
        .destination_s3_uri = "destinationS3Uri",
        .job_id = "jobId",
        .started_at = "startedAt",
        .status = "status",
    };
};
