const ProcessingS3UploadMode = @import("processing_s3_upload_mode.zig").ProcessingS3UploadMode;

/// Configuration for uploading output data to Amazon S3 from the processing
/// container.
pub const ProcessingS3Output = struct {
    /// The local path of a directory where you want Amazon SageMaker to upload its
    /// contents to Amazon S3. `LocalPath` is an absolute path to a directory
    /// containing output files. This directory will be created by the platform and
    /// exist when your container's entrypoint is invoked.
    local_path: ?[]const u8,

    /// Whether to upload the results of the processing job continuously or after
    /// the job completes.
    s3_upload_mode: ProcessingS3UploadMode,

    /// A URI that identifies the Amazon S3 bucket where you want Amazon SageMaker
    /// to save the results of a processing job.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .local_path = "LocalPath",
        .s3_upload_mode = "S3UploadMode",
        .s3_uri = "S3Uri",
    };
};
