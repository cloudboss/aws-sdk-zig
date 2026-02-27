const ServiceLevelIndicatorComparisonOperator = @import("service_level_indicator_comparison_operator.zig").ServiceLevelIndicatorComparisonOperator;
const RequestBasedServiceLevelIndicatorMetric = @import("request_based_service_level_indicator_metric.zig").RequestBasedServiceLevelIndicatorMetric;

/// This structure contains information about the performance metric that a
/// request-based SLO monitors.
pub const RequestBasedServiceLevelIndicator = struct {
    /// The arithmetic operation used when comparing the specified metric to the
    /// threshold.
    comparison_operator: ?ServiceLevelIndicatorComparisonOperator,

    /// This value is the threshold that the observed metric values of the SLI
    /// metric are compared to.
    metric_threshold: ?f64,

    /// A structure that contains information about the metric that the SLO
    /// monitors.
    request_based_sli_metric: RequestBasedServiceLevelIndicatorMetric,

    pub const json_field_names = .{
        .comparison_operator = "ComparisonOperator",
        .metric_threshold = "MetricThreshold",
        .request_based_sli_metric = "RequestBasedSliMetric",
    };
};
