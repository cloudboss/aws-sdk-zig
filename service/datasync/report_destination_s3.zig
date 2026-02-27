/// Specifies the Amazon S3 bucket where DataSync uploads your [task
/// report](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
pub const ReportDestinationS3 = struct {
    /// Specifies the Amazon Resource Name (ARN) of the IAM policy that allows
    /// DataSync to upload a task report to your S3 bucket. For more information,
    /// see
    /// [Allowing
    /// DataSync to upload a task report to an Amazon S3
    /// bucket](https://docs.aws.amazon.com/datasync/latest/userguide/task-reports.html).
    bucket_access_role_arn: []const u8,

    /// Specifies the ARN of the S3 bucket where DataSync uploads your report.
    s3_bucket_arn: []const u8,

    /// Specifies a bucket prefix for your report.
    subdirectory: ?[]const u8,

    pub const json_field_names = .{
        .bucket_access_role_arn = "BucketAccessRoleArn",
        .s3_bucket_arn = "S3BucketArn",
        .subdirectory = "Subdirectory",
    };
};
