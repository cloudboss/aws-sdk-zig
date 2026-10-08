/// S3 configuration for report output.
pub const S3ReportOutputConfiguration = struct {
    /// Account ID of the bucket owner for cross-account access verification.
    bucket_owner: []const u8,

    /// S3 bucket path where reports will be written (e.g.,
    /// my-bucket/ngrh-reports/).
    bucket_path: []const u8,

    pub const json_field_names = .{
        .bucket_owner = "bucketOwner",
        .bucket_path = "bucketPath",
    };
};
