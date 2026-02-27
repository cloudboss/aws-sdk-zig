/// The settings for the source S3 bucket.
pub const S3ImportSource = struct {
    /// The IAM ARN role used to access the source S3 bucket.
    s3_bucket_access_role_arn: []const u8,

    /// The Region associated with the source S3 bucket.
    s3_bucket_region: []const u8,

    /// The URI for the source S3 bucket.
    s3_location_uri: []const u8,

    pub const json_field_names = .{
        .s3_bucket_access_role_arn = "S3BucketAccessRoleArn",
        .s3_bucket_region = "S3BucketRegion",
        .s3_location_uri = "S3LocationUri",
    };
};
