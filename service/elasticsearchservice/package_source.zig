/// The S3 location for importing the package specified as `S3BucketName` and
/// `S3Key`
pub const PackageSource = struct {
    /// Name of the bucket containing the package.
    s3_bucket_name: ?[]const u8,

    /// Key (file name) of the package.
    s3_key: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .s3_key = "S3Key",
    };
};
