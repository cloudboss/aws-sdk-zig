const S3BucketLogDestination = @import("s3_bucket_log_destination.zig").S3BucketLogDestination;

/// The location of audio log files collected when conversation logging
/// is enabled for a bot.
pub const AudioLogDestination = struct {
    /// The Amazon S3 bucket where the audio log files are stored. The IAM
    /// role specified in the `roleArn` parameter of the
    /// [CreateBot](https://docs.aws.amazon.com/lexv2/latest/APIReference/API_CreateBot.html) operation must have permission to write to this
    /// bucket.
    s_3_bucket: S3BucketLogDestination,

    pub const json_field_names = .{
        .s_3_bucket = "s3Bucket",
    };
};
