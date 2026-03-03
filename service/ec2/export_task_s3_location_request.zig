/// Describes the destination for an export image task.
pub const ExportTaskS3LocationRequest = struct {
    /// The destination Amazon S3 bucket.
    s3_bucket: []const u8,

    /// The prefix (logical hierarchy) in the bucket.
    s3_prefix: ?[]const u8 = null,
};
