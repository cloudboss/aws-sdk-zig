const FailedReportOutput = @import("failed_report_output.zig").FailedReportOutput;
const S3ReportOutput = @import("s3_report_output.zig").S3ReportOutput;

/// The output location or cause of a failure in report generation.
pub const ReportOutput = union(enum) {
    /// The details about a failed report generation.
    failed_report_output: ?FailedReportOutput,
    /// Information about a report delivered to Amazon S3.
    s_3_report_output: ?S3ReportOutput,

    pub const json_field_names = .{
        .failed_report_output = "failedReportOutput",
        .s_3_report_output = "s3ReportOutput",
    };
};
