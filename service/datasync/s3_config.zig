/// Specifies the Amazon Resource Name (ARN) of the Identity and Access
/// Management (IAM) role that DataSync uses to access your S3 bucket.
///
/// For more information, see [Providing
/// DataSync access to S3
/// buckets](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#create-s3-location-access).
pub const S3Config = struct {
    /// Specifies the ARN of the IAM role that DataSync uses to access
    /// your S3 bucket.
    bucket_access_role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_access_role_arn = "BucketAccessRoleArn",
    };
};
