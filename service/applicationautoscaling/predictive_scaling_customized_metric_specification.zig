const PredictiveScalingMetricDataQuery = @import("predictive_scaling_metric_data_query.zig").PredictiveScalingMetricDataQuery;

/// Represents a CloudWatch metric of your choosing for a predictive scaling
/// policy.
pub const PredictiveScalingCustomizedMetricSpecification = struct {
    /// One or more metric data queries to provide data points for a metric
    /// specification.
    metric_data_queries: []const PredictiveScalingMetricDataQuery,

    pub const json_field_names = .{
        .metric_data_queries = "MetricDataQueries",
    };
};
