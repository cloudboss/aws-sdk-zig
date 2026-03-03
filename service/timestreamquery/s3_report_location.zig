/// S3 report location for the scheduled query run.
pub const S3ReportLocation = struct {
    /// S3 bucket name.
    bucket_name: ?[]const u8 = null,

    /// S3 key.
    object_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
    };
};
