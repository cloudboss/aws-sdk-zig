const ExperimentTemplateReportConfigurationDataSources = @import("experiment_template_report_configuration_data_sources.zig").ExperimentTemplateReportConfigurationDataSources;
const ExperimentTemplateReportConfigurationOutputs = @import("experiment_template_report_configuration_outputs.zig").ExperimentTemplateReportConfigurationOutputs;

/// Describes the experiment report configuration. For more information, see
/// [Experiment report configurations for AWS
/// FIS](https://docs.aws.amazon.com/fis/latest/userguide/experiment-report-configuration).
pub const ExperimentTemplateReportConfiguration = struct {
    /// The data sources for the experiment report.
    data_sources: ?ExperimentTemplateReportConfigurationDataSources = null,

    /// Describes the output destinations of the experiment report.
    outputs: ?ExperimentTemplateReportConfigurationOutputs = null,

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
