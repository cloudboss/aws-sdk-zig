/// Configuration for delivering generated reports to an Amazon S3 bucket.
pub const S3ReportOutputConfiguration = struct {
    /// The Amazon Web Services account ID that owns the S3 bucket. Required to
    /// ensure the bucket is still owned by the same expected owner at generation
    /// time.
    bucket_owner: ?[]const u8 = null,

    /// The S3 bucket name and optional prefix where reports are stored. Format:
    /// bucket-name or bucket-name/prefix.
    bucket_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_owner = "bucketOwner",
        .bucket_path = "bucketPath",
    };
};
