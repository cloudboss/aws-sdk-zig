const ServiceLevelIndicatorComparisonOperator = @import("service_level_indicator_comparison_operator.zig").ServiceLevelIndicatorComparisonOperator;
const ServiceLevelIndicatorMetricConfig = @import("service_level_indicator_metric_config.zig").ServiceLevelIndicatorMetricConfig;

/// This structure specifies the information about the service and the
/// performance metric that a period-based SLO is to monitor.
pub const ServiceLevelIndicatorConfig = struct {
    /// The arithmetic operation to use when comparing the specified metric to the
    /// threshold.
    ///
    /// This is not required if `CreateRecommendedSlo` is set to `true`.
    comparison_operator: ServiceLevelIndicatorComparisonOperator = .less_than,

    /// This parameter is used only when a request-based SLO tracks the `Latency`
    /// metric. Specify the threshold value that the observed `Latency` metric
    /// values are to be compared to.
    ///
    /// This is not required if `CreateRecommendedSlo` is set to `true`.
    metric_threshold: f64 = 0,

    /// Use this structure to specify the metric to be used for the SLO.
    sli_metric_config: ServiceLevelIndicatorMetricConfig,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .metric_threshold = "MetricThreshold",
        .sli_metric_config = "SliMetricConfig",
    };
};
