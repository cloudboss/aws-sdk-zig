const UploadJobStatus = @import("upload_job_status.zig").UploadJobStatus;
const StatusReason = @import("status_reason.zig").StatusReason;

/// The summary information for an individual upload job.
pub const UploadJobItem = struct {
    /// The timestamp when the upload job was completed.
    completed_at: ?i64,

    /// The timestamp when the upload job was created.
    created_at: ?i64,

    /// The expiry duration for the profiles ingested with the upload job.
    data_expiry: ?i32,

    /// The name of the upload job.
    display_name: ?[]const u8,

    /// The unique identifier of the upload job.
    job_id: ?[]const u8,

    /// The current status of the upload job.
    status: ?UploadJobStatus,

    /// The reason for the current status of the upload job.
    status_reason: ?StatusReason,

    pub const json_field_names = .{
        .completed_at = "CompletedAt",
        .created_at = "CreatedAt",
        .data_expiry = "DataExpiry",
        .display_name = "DisplayName",
        .job_id = "JobId",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
