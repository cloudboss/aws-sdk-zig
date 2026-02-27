const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// Configuration required for error reporting.
pub const ErrorReportConfiguration = struct {
    /// The S3 configuration for the error reports.
    s3_configuration: S3Configuration,

    pub const json_field_names = .{
        .s3_configuration = "S3Configuration",
    };
};
