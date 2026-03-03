const aws = @import("aws");

const DQResultsPublishingOptions = @import("dq_results_publishing_options.zig").DQResultsPublishingOptions;
const DQStopJobOnFailureOptions = @import("dq_stop_job_on_failure_options.zig").DQStopJobOnFailureOptions;

/// Specifies your data quality evaluation criteria.
pub const EvaluateDataQualityMultiFrame = struct {
    /// The aliases of all data sources except primary.
    additional_data_sources: ?[]const aws.map.StringMapEntry = null,

    /// Options to configure runtime behavior of the transform.
    additional_options: ?[]const aws.map.StringMapEntry = null,

    /// The inputs of your data quality evaluation. The first input in this list is
    /// the primary data source.
    inputs: []const []const u8,

    /// The name of the data quality evaluation.
    name: []const u8,

    /// Options to configure how your results are published.
    publishing_options: ?DQResultsPublishingOptions = null,

    /// The ruleset for your data quality evaluation.
    ruleset: []const u8,

    /// Options to configure how your job will stop if your data quality evaluation
    /// fails.
    stop_job_on_failure_options: ?DQStopJobOnFailureOptions = null,

    pub const json_field_names = .{
        .additional_data_sources = "AdditionalDataSources",
        .additional_options = "AdditionalOptions",
        .inputs = "Inputs",
        .name = "Name",
        .publishing_options = "PublishingOptions",
        .ruleset = "Ruleset",
        .stop_job_on_failure_options = "StopJobOnFailureOptions",
    };
};
