const LambdaFunctionMemoryMetricName = @import("lambda_function_memory_metric_name.zig").LambdaFunctionMemoryMetricName;
const LambdaFunctionMemoryMetricStatistic = @import("lambda_function_memory_metric_statistic.zig").LambdaFunctionMemoryMetricStatistic;

/// Describes a projected utilization metric of an Lambda function
/// recommendation option.
pub const LambdaFunctionMemoryProjectedMetric = struct {
    /// The name of the projected utilization metric.
    name: ?LambdaFunctionMemoryMetricName,

    /// The statistic of the projected utilization metric.
    statistic: ?LambdaFunctionMemoryMetricStatistic,

    /// The values of the projected utilization metrics.
    value: f64 = 0,

    pub const json_field_names = .{
        .name = "name",
        .statistic = "statistic",
        .value = "value",
    };
};
