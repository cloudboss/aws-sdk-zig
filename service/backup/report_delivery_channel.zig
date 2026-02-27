/// Contains information from your report plan about where to deliver your
/// reports,
/// specifically your Amazon S3 bucket name, S3 key prefix, and the formats of
/// your
/// reports.
pub const ReportDeliveryChannel = struct {
    /// The format of your reports: `CSV`, `JSON`, or both. If
    /// not specified, the default format is `CSV`.
    formats: ?[]const []const u8,

    /// The unique name of the S3 bucket that receives your reports.
    s3_bucket_name: []const u8,

    /// The prefix for where Backup Audit Manager delivers your reports to Amazon
    /// S3. The prefix is this part of the following path:
    /// s3://your-bucket-name/`prefix`/Backup/us-west-2/year/month/day/report-name.
    /// If not specified, there is no prefix.
    s3_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .formats = "Formats",
        .s3_bucket_name = "S3BucketName",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
