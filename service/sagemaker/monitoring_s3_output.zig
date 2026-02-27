const ProcessingS3UploadMode = @import("processing_s3_upload_mode.zig").ProcessingS3UploadMode;

/// Information about where and how you want to store the results of a
/// monitoring job.
pub const MonitoringS3Output = struct {
    /// The local path to the Amazon S3 storage location where Amazon SageMaker AI
    /// saves the results of a monitoring job. LocalPath is an absolute path for the
    /// output data.
    local_path: []const u8,

    /// Whether to upload the results of the monitoring job continuously or after
    /// the job completes.
    s3_upload_mode: ?ProcessingS3UploadMode,

    /// A URI that identifies the Amazon S3 storage location where Amazon SageMaker
    /// AI saves the results of a monitoring job.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .s3_upload_mode = "S3UploadMode",
        .s3_uri = "S3Uri",
    };
};
