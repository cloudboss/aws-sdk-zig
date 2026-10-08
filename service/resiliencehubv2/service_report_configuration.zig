const ReportOutputConfiguration = @import("report_output_configuration.zig").ReportOutputConfiguration;

/// Configuration for automatic report generation on a Service.
pub const ServiceReportConfiguration = struct {
    /// Output destinations for generated reports.
    report_outputs: []const ReportOutputConfiguration,

    pub const json_field_names = .{
        .report_outputs = "reportOutputs",
    };
};
