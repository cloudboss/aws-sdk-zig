/// Contains information from your report job about your report destination.
pub const ReportDestination = struct {
    /// The unique name of the Amazon S3 bucket that receives your reports.
    s3_bucket_name: ?[]const u8,

    /// The object key that uniquely identifies your reports in your S3 bucket.
    s3_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .s3_bucket_name = "S3BucketName",
        .s3_keys = "S3Keys",
    };
};
