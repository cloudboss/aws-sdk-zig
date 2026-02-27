const ReportS3Configuration = @import("report_s3_configuration.zig").ReportS3Configuration;

/// Report configuration for a batch load task. This contains details about
/// where error
/// reports are stored.
pub const ReportConfiguration = struct {
    /// Configuration of an S3 location to write error reports and events for a
    /// batch
    /// load.
    report_s3_configuration: ?ReportS3Configuration,

    pub const json_field_names = .{
        .report_s3_configuration = "ReportS3Configuration",
    };
};
