const ExperimentReportName = @import("experiment_report_name.zig").ExperimentReportName;

/// A structure that contains results of an experiment.
pub const ExperimentReport = struct {
    /// The content of the report.
    content: ?[]const u8,

    /// The name of the metric that is analyzed in this experiment report.
    metric_name: ?[]const u8,

    /// The type of analysis used for this report.
    report_name: ?ExperimentReportName,

    /// The name of the variation that this report pertains to.
    treatment_name: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .metric_name = "metricName",
        .report_name = "reportName",
        .treatment_name = "treatmentName",
    };
};
