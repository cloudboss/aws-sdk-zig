/// Specifies an Amazon S3 bucket for logging audio conversations
pub const S3BucketLogDestination = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services Key Management
    /// Service
    /// (KMS) key for encrypting audio log files stored in an S3 bucket.
    kms_key_arn: ?[]const u8 = null,

    /// The S3 prefix to assign to audio log files.
    log_prefix: []const u8,

    /// The Amazon Resource Name (ARN) of an Amazon S3 bucket where audio
    /// log files are stored.
    s_3_bucket_arn: []const u8,

    pub const json_field_names = .{
        .kms_key_arn = "kmsKeyArn",
        .log_prefix = "logPrefix",
        .s_3_bucket_arn = "s3BucketArn",
    };
};
