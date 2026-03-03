const JobStatus = @import("job_status.zig").JobStatus;

/// Summary of import job.
pub const DICOMImportJobSummary = struct {
    /// The Amazon Resource Name (ARN) that grants permissions to access medical
    /// imaging resources.
    data_access_role_arn: ?[]const u8 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The timestamp when an import job ended.
    ended_at: ?i64 = null,

    /// The import job identifier.
    job_id: []const u8,

    /// The import job name.
    job_name: []const u8,

    /// The filters for listing import jobs based on status.
    job_status: JobStatus,

    /// The error message thrown if an import job fails.
    message: ?[]const u8 = null,

    /// The timestamp when an import job was submitted.
    submitted_at: ?i64 = null,

    pub const json_field_names = .{
        .data_access_role_arn = "dataAccessRoleArn",
        .datastore_id = "datastoreId",
        .ended_at = "endedAt",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_status = "jobStatus",
        .message = "message",
        .submitted_at = "submittedAt",
    };
};
