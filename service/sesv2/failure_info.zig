/// An object that contains the failure details about a job.
pub const FailureInfo = struct {
    /// A message about why the job failed.
    error_message: ?[]const u8 = null,

    /// An Amazon S3 pre-signed URL that contains all the failed records and related
    /// information.
    failed_records_s3_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .failed_records_s3_url = "FailedRecordsS3Url",
    };
};
