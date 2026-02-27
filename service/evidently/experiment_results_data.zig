const ExperimentResultResponseType = @import("experiment_result_response_type.zig").ExperimentResultResponseType;

/// A structure that contains experiment results for one metric that is
/// monitored in the experiment.
pub const ExperimentResultsData = struct {
    /// The name of the metric.
    metric_name: ?[]const u8,

    /// The experiment statistic that these results pertain to.
    result_stat: ?ExperimentResultResponseType,

    /// The treatment, or variation, that returned the `values` in this structure.
    treatment_name: ?[]const u8,

    /// The values for the `metricName` that were recorded in the experiment.
    values: ?[]const f64,

    pub const json_field_names = .{
        .metric_name = "metricName",
        .result_stat = "resultStat",
        .treatment_name = "treatmentName",
        .values = "values",
    };
};
