const ServiceLevelIndicatorComparisonOperator = @import("service_level_indicator_comparison_operator.zig").ServiceLevelIndicatorComparisonOperator;
const RequestBasedServiceLevelIndicatorMetricConfig = @import("request_based_service_level_indicator_metric_config.zig").RequestBasedServiceLevelIndicatorMetricConfig;

/// This structure specifies the information about the service and the
/// performance metric that a request-based SLO is to monitor.
pub const RequestBasedServiceLevelIndicatorConfig = struct {
    /// The arithmetic operation to use when comparing the specified metric to the
    /// threshold. This parameter is required if this SLO is tracking the `Latency`
    /// metric.
    comparison_operator: ?ServiceLevelIndicatorComparisonOperator = null,

    /// The value that the SLI metric is compared to. This parameter is required if
    /// this SLO is tracking the `Latency` metric.
    metric_threshold: ?f64 = null,

    /// Use this structure to specify the metric to be used for the SLO.
    request_based_sli_metric_config: RequestBasedServiceLevelIndicatorMetricConfig,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .metric_threshold = "MetricThreshold",
        .request_based_sli_metric_config = "RequestBasedSliMetricConfig",
    };
};
