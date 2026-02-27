const ExperimentReportConfigurationOutputsS3Configuration = @import("experiment_report_configuration_outputs_s3_configuration.zig").ExperimentReportConfigurationOutputsS3Configuration;

/// Describes the output destinations of the experiment report.
pub const ExperimentReportConfigurationOutputs = struct {
    /// The S3 destination for the experiment report.
    s_3_configuration: ?ExperimentReportConfigurationOutputsS3Configuration,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
