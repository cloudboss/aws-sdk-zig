/// An S3 bucket where you want to store the results of this request.
pub const S3OutputLocation = struct {
    /// The name of the S3 bucket.
    output_s3_bucket_name: ?[]const u8 = null,

    /// The S3 bucket subfolder.
    output_s3_key_prefix: ?[]const u8 = null,

    /// The Amazon Web Services Region of the S3 bucket.
    output_s3_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_s3_bucket_name = "OutputS3BucketName",
        .output_s3_key_prefix = "OutputS3KeyPrefix",
        .output_s3_region = "OutputS3Region",
    };
};
