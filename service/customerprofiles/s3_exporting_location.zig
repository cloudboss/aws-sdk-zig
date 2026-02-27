/// The S3 location where Identity Resolution Jobs write result files.
pub const S3ExportingLocation = struct {
    /// The name of the S3 bucket name where Identity Resolution Jobs write result
    /// files.
    s3_bucket_name: ?[]const u8,

    /// The S3 key name of the location where Identity Resolution Jobs write result
    /// files.
    s3_key_name: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .s3_key_name = "S3KeyName",
    };
};
