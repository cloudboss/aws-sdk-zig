const ReportConfigurationS3OutputInput = @import("report_configuration_s3_output_input.zig").ReportConfigurationS3OutputInput;

/// Specifies the outputs for the experiment templates.
pub const ExperimentTemplateReportConfigurationOutputsInput = struct {
    /// The S3 destination for the experiment report.
    s_3_configuration: ?ReportConfigurationS3OutputInput = null,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
