/// S3 report location for the scheduled query run.
pub const S3ReportLocation = struct {
    /// S3 bucket name.
    bucket_name: ?[]const u8,

    /// S3 key.
    object_key: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_key = "ObjectKey",
    };
};
