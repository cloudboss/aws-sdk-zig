const ServiceLevelIndicatorComparisonOperator = @import("service_level_indicator_comparison_operator.zig").ServiceLevelIndicatorComparisonOperator;
const ServiceLevelIndicatorMetric = @import("service_level_indicator_metric.zig").ServiceLevelIndicatorMetric;

/// This structure contains information about the performance metric that a
/// period-based SLO monitors.
pub const ServiceLevelIndicator = struct {
    /// The arithmetic operation used when comparing the specified metric to the
    /// threshold.
    comparison_operator: ServiceLevelIndicatorComparisonOperator,

    /// The value that the SLI metric is compared to.
    metric_threshold: f64,

    /// A structure that contains information about the metric that the SLO
    /// monitors.
    sli_metric: ServiceLevelIndicatorMetric,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .metric_threshold = "MetricThreshold",
        .sli_metric = "SliMetric",
    };
};
