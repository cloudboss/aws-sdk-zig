/// The Amazon S3 location to import the package from.
pub const PackageSource = struct {
    /// The name of the Amazon S3 bucket containing the package.
    s3_bucket_name: ?[]const u8 = null,

    /// Key (file name) of the package.
    s3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .s3_key = "S3Key",
    };
};
