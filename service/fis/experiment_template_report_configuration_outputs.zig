const ReportConfigurationS3Output = @import("report_configuration_s3_output.zig").ReportConfigurationS3Output;

/// The output destinations of the experiment report.
pub const ExperimentTemplateReportConfigurationOutputs = struct {
    /// The S3 destination for the experiment report.
    s_3_configuration: ?ReportConfigurationS3Output,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
