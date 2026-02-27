/// Provides information that defines a schema conversion application.
pub const SCApplicationAttributes = struct {
    /// The path for the Amazon S3 bucket that the application uses for exporting
    /// assessment reports.
    s3_bucket_path: ?[]const u8,

    /// The ARN for the role the application uses to access its Amazon S3 bucket.
    s3_bucket_role_arn: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket_path = "S3BucketPath",
        .s3_bucket_role_arn = "S3BucketRoleArn",
    };
};
