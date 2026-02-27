const ExperimentTemplateReportConfigurationDataSourcesInput = @import("experiment_template_report_configuration_data_sources_input.zig").ExperimentTemplateReportConfigurationDataSourcesInput;
const ExperimentTemplateReportConfigurationOutputsInput = @import("experiment_template_report_configuration_outputs_input.zig").ExperimentTemplateReportConfigurationOutputsInput;

/// Specifies the configuration for experiment reports.
pub const CreateExperimentTemplateReportConfigurationInput = struct {
    /// The data sources for the experiment report.
    data_sources: ?ExperimentTemplateReportConfigurationDataSourcesInput,

    /// The output destinations of the experiment report.
    outputs: ?ExperimentTemplateReportConfigurationOutputsInput,

    /// The duration after the experiment end time for the data sources to include
    /// in the report.
    post_experiment_duration: ?[]const u8,

    /// The duration before the experiment start time for the data sources to
    /// include in the report.
    pre_experiment_duration: ?[]const u8,

    pub const json_field_names = .{
        .data_sources = "dataSources",
        .outputs = "outputs",
        .post_experiment_duration = "postExperimentDuration",
        .pre_experiment_duration = "preExperimentDuration",
    };
};
