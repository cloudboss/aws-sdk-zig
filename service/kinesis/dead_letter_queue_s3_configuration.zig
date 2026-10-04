/// The Amazon S3 dead-letter queue configuration for records that cannot be
/// delivered.
pub const DeadLetterQueueS3Configuration = struct {
    /// The Amazon Resource Name (ARN) of the dead-letter queue Amazon S3 bucket.
    bucket_arn: []const u8,

    /// The Amazon S3 key prefix for error records.
    error_output_prefix: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the expected owner of the dead-letter
    /// queue bucket.
    expected_bucket_owner: []const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .error_output_prefix = "ErrorOutputPrefix",
        .expected_bucket_owner = "ExpectedBucketOwner",
    };
};
