const JobStatus = @import("job_status.zig").JobStatus;

/// Properties of the import job.
pub const DICOMImportJobProperties = struct {
    /// The Amazon Resource Name (ARN) that grants permissions to access medical
    /// imaging resources.
    data_access_role_arn: []const u8,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The timestamp for when the import job was ended.
    ended_at: ?i64 = null,

    /// The input prefix path for the S3 bucket that contains the DICOM P10 files to
    /// be imported.
    input_s3_uri: []const u8,

    /// The import job identifier.
    job_id: []const u8,

    /// The import job name.
    job_name: []const u8,

    /// The filters for listing import jobs based on status.
    job_status: JobStatus,

    /// The error message thrown if an import job fails.
    message: ?[]const u8 = null,

    /// The output prefix of the S3 bucket to upload the results of the DICOM import
    /// job.
    output_s3_uri: []const u8,

    /// The timestamp for when the import job was submitted.
    submitted_at: ?i64 = null,

    pub const json_field_names = .{
        .data_access_role_arn = "dataAccessRoleArn",
        .datastore_id = "datastoreId",
        .ended_at = "endedAt",
        .input_s3_uri = "inputS3Uri",
        .job_id = "jobId",
        .job_name = "jobName",
        .job_status = "jobStatus",
        .message = "message",
        .output_s3_uri = "outputS3Uri",
        .submitted_at = "submittedAt",
    };
};
