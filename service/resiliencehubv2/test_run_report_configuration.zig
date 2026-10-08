const ReportOutputConfiguration = @import("report_output_configuration.zig").ReportOutputConfiguration;

/// A snapshot of the report configuration captured onto a test run from the
/// service when the run was started.
pub const TestRunReportConfiguration = struct {
    /// The output destinations for generated reports.
    report_output: []const ReportOutputConfiguration,

    pub const json_field_names = .{
        .report_output = "reportOutput",
    };
};
