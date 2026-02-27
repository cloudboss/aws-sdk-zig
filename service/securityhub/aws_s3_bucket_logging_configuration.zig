/// Information about logging for
/// the S3 bucket
pub const AwsS3BucketLoggingConfiguration = struct {
    /// The name of the S3 bucket where log files for the S3 bucket are stored.
    destination_bucket_name: ?[]const u8,

    /// The prefix added to log files for the S3 bucket.
    log_file_prefix: ?[]const u8,

    pub const json_field_names = .{
        .destination_bucket_name = "DestinationBucketName",
        .log_file_prefix = "LogFilePrefix",
    };
};
