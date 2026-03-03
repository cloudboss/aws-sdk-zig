const S3OutputFormat = @import("s3_output_format.zig").S3OutputFormat;

/// The Amazon S3 logging configuration settings for the pipe.
pub const S3LogDestination = struct {
    /// The name of the Amazon S3 bucket to which EventBridge delivers the log
    /// records for the pipe.
    bucket_name: ?[]const u8 = null,

    /// The Amazon Web Services account that owns the Amazon S3 bucket to which
    /// EventBridge delivers the log records for the pipe.
    bucket_owner: ?[]const u8 = null,

    /// The format EventBridge uses for the log records.
    ///
    /// EventBridge currently only supports `json` formatting.
    output_format: ?S3OutputFormat = null,

    /// The prefix text with which to begin Amazon S3 log object names.
    ///
    /// For more information, see [Organizing objects using
    /// prefixes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html) in the *Amazon Simple Storage Service User Guide*.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .bucket_owner = "BucketOwner",
        .output_format = "OutputFormat",
        .prefix = "Prefix",
    };
};
