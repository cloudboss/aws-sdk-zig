/// Describes the S3 destination for the experiment report.
pub const ReportConfigurationS3Output = struct {
    /// The name of the S3 bucket where the experiment report will be stored.
    bucket_name: ?[]const u8 = null,

    /// The prefix of the S3 bucket where the experiment report will be stored.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .prefix = "prefix",
    };
};
