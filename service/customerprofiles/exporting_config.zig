const S3ExportingConfig = @import("s3_exporting_config.zig").S3ExportingConfig;

/// Configuration information about the S3 bucket where Identity Resolution Jobs
/// writes result files.
///
/// You need to give Customer Profiles service principal write permission to
/// your S3 bucket.
/// Otherwise, you'll get an exception in the API response. For an example
/// policy, see
/// [Amazon Connect Customer Profiles cross-service confused deputy
/// prevention](https://docs.aws.amazon.com/connect/latest/adminguide/cross-service-confused-deputy-prevention.html#customer-profiles-cross-service).
pub const ExportingConfig = struct {
    /// The S3 location where Identity Resolution Jobs write result files.
    s3_exporting: ?S3ExportingConfig,

    pub const json_field_names = .{
        .s3_exporting = "S3Exporting",
    };
};
