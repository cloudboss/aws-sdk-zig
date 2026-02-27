const CustomMetricDefinition = @import("custom_metric_definition.zig").CustomMetricDefinition;

/// An array item definining a single custom metric for use in an Amazon Bedrock
/// evaluation job.
pub const AutomatedEvaluationCustomMetricSource = union(enum) {
    /// The definition of a custom metric for use in an Amazon Bedrock evaluation
    /// job.
    custom_metric_definition: ?CustomMetricDefinition,

    pub const json_field_names = .{
        .custom_metric_definition = "customMetricDefinition",
    };
};
