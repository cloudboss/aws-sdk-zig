const AnalyticsS3ExportFileFormat = @import("analytics_s3_export_file_format.zig").AnalyticsS3ExportFileFormat;

/// Contains information about where to publish the analytics results.
pub const AnalyticsS3BucketDestination = struct {
    /// The Amazon Resource Name (ARN) of the bucket to which data is exported.
    bucket: []const u8,

    /// The account ID that owns the destination S3 bucket. If no account ID is
    /// provided, the owner is not
    /// validated before exporting data.
    ///
    /// Although this value is optional, we strongly recommend that you set it to
    /// help prevent problems
    /// if the destination bucket ownership changes.
    bucket_account_id: ?[]const u8 = null,

    /// Specifies the file format used when exporting data to Amazon S3.
    format: AnalyticsS3ExportFileFormat,

    /// The prefix to use when exporting data. The prefix is prepended to all
    /// results.
    prefix: ?[]const u8 = null,
};
