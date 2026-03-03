const S3ReportLocation = @import("s3_report_location.zig").S3ReportLocation;

/// This contains the location of the error report for a single scheduled query
/// call.
pub const ErrorReportLocation = struct {
    /// The S3 location where error reports are written.
    s3_report_location: ?S3ReportLocation = null,

    pub const json_field_names = .{
        .s3_report_location = "S3ReportLocation",
    };
};
