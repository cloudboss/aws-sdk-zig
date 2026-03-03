const DQTransformOutput = @import("dq_transform_output.zig").DQTransformOutput;
const DQResultsPublishingOptions = @import("dq_results_publishing_options.zig").DQResultsPublishingOptions;
const DQStopJobOnFailureOptions = @import("dq_stop_job_on_failure_options.zig").DQStopJobOnFailureOptions;

/// Specifies your data quality evaluation criteria.
pub const EvaluateDataQuality = struct {
    /// The inputs of your data quality evaluation.
    inputs: []const []const u8,

    /// The name of the data quality evaluation.
    name: []const u8,

    /// The output of your data quality evaluation.
    output: ?DQTransformOutput = null,

    /// Options to configure how your results are published.
    publishing_options: ?DQResultsPublishingOptions = null,

    /// The ruleset for your data quality evaluation.
    ruleset: []const u8,

    /// Options to configure how your job will stop if your data quality evaluation
    /// fails.
    stop_job_on_failure_options: ?DQStopJobOnFailureOptions = null,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .output = "Output",
        .publishing_options = "PublishingOptions",
        .ruleset = "Ruleset",
        .stop_job_on_failure_options = "StopJobOnFailureOptions",
    };
};
