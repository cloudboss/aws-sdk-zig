const ExperimentReportConfigurationDataSources = @import("experiment_report_configuration_data_sources.zig").ExperimentReportConfigurationDataSources;
const ExperimentReportConfigurationOutputs = @import("experiment_report_configuration_outputs.zig").ExperimentReportConfigurationOutputs;

/// Describes the report configuration for the experiment. For more information,
/// see [Experiment report configurations for AWS
/// FIS](https://docs.aws.amazon.com/fis/latest/userguide/experiment-report-configuration).
pub const ExperimentReportConfiguration = struct {
    /// The data sources for the experiment report.
    data_sources: ?ExperimentReportConfigurationDataSources = null,

    /// The output destinations of the experiment report.
    outputs: ?ExperimentReportConfigurationOutputs = null,

    /// The duration after the experiment end time for the data sources to include
    /// in the report.
    post_experiment_duration: ?[]const u8 = null,

    /// The duration before the experiment start time for the data sources to
    /// include in the report.
    pre_experiment_duration: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_sources = "dataSources",
        .outputs = "outputs",
        .post_experiment_duration = "postExperimentDuration",
        .pre_experiment_duration = "preExperimentDuration",
    };
};
