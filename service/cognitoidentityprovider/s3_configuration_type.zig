/// Configuration for the Amazon S3 bucket destination of user activity log
/// export with threat
/// protection.
pub const S3ConfigurationType = struct {
    /// The ARN of an Amazon S3 bucket that's the destination for threat protection
    /// log
    /// export.
    bucket_arn: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn = "BucketArn",
    };
};
