const FailedReportOutput = @import("failed_report_output.zig").FailedReportOutput;
const S3ReportOutput = @import("s3_report_output.zig").S3ReportOutput;

/// Union of possible report outputs.
pub const ReportOutput = union(enum) {
    /// Details when report generation failed.
    failed_report_output: ?FailedReportOutput,
    /// The S3 location where the report was written.
    s_3_report_output: ?S3ReportOutput,

    pub const json_field_names = .{
        .failed_report_output = "failedReportOutput",
        .s_3_report_output = "s3ReportOutput",
    };
};
