/// Configuration of the Amazon S3 bucket where records that fail to deliver are
/// stored.
pub const DeadLetterQueueS3 = struct {
    /// The Amazon Resource Name (ARN) of the dead-letter Amazon S3 bucket.
    bucket_arn: []const u8,

    /// An optional prefix prepended to every dead-letter Amazon S3 object key.
    error_output_prefix: ?[]const u8 = null,

    /// Optional 12-digit AWS account ID expected to own the dead-letter Amazon S3
    /// bucket.
    expected_bucket_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketArn",
        .error_output_prefix = "ErrorOutputPrefix",
        .expected_bucket_owner = "ExpectedBucketOwner",
    };
};
