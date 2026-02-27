/// Configuration for S3 bucket log delivery.
pub const S3Configuration = struct {
    /// The name of the S3 bucket to deliver logs to.
    bucket_name: []const u8,

    /// Indicates whether log delivery to the S3 bucket is enabled.
    enabled: bool,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .enabled = "enabled",
    };
};
