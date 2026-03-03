const ReportOutputConfiguration = @import("report_output_configuration.zig").ReportOutputConfiguration;

/// Configuration for automatic report generation for plan executions. When
/// configured, Region switch automatically generates a report after each plan
/// execution that includes execution events, plan configuration, and CloudWatch
/// alarm states.
pub const ReportConfiguration = struct {
    /// The output configuration for the report.
    report_output: ?[]const ReportOutputConfiguration = null,

    pub const json_field_names = .{
        .report_output = "reportOutput",
    };
};
