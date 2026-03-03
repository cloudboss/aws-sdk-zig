const AutoMLMetricEnum = @import("auto_ml_metric_enum.zig").AutoMLMetricEnum;
const MetricSetSource = @import("metric_set_source.zig").MetricSetSource;
const AutoMLMetricExtendedEnum = @import("auto_ml_metric_extended_enum.zig").AutoMLMetricExtendedEnum;

/// Information about the metric for a candidate produced by an AutoML job.
pub const MetricDatum = struct {
    /// The name of the metric.
    metric_name: ?AutoMLMetricEnum = null,

    /// The dataset split from which the AutoML job produced the metric.
    set: ?MetricSetSource = null,

    /// The name of the standard metric.
    ///
    /// For definitions of the standard metrics, see [ `Autopilot candidate metrics`
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/autopilot-model-support-validation.html#autopilot-metrics).
    standard_metric_name: ?AutoMLMetricExtendedEnum = null,

    /// The value of the metric.
    value: ?f32 = null,

    pub const json_field_names = .{
        .metric_name = "MetricName",
        .set = "Set",
        .standard_metric_name = "StandardMetricName",
        .value = "Value",
    };
};
