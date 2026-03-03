const ECSServiceMetricName = @import("ecs_service_metric_name.zig").ECSServiceMetricName;
const ECSServiceMetricStatistic = @import("ecs_service_metric_statistic.zig").ECSServiceMetricStatistic;

/// Describes the projected utilization metrics of an Amazon ECS service
/// recommendation option.
///
/// To determine the performance difference between your current Amazon ECS
/// service and the recommended option,
/// compare the utilization metric data of your service against its projected
/// utilization metric data.
pub const ECSServiceProjectedUtilizationMetric = struct {
    /// The lower bound values for the projected utilization metrics.
    lower_bound_value: f64 = 0,

    /// The name of the projected utilization metric.
    ///
    /// The following utilization metrics are available:
    ///
    /// * `Cpu` — The percentage of allocated compute units
    /// that are currently in use on the service tasks.
    ///
    /// * `Memory` — The percentage of memory that's
    /// currently in use on the service tasks.
    name: ?ECSServiceMetricName = null,

    /// The statistic of the projected utilization metric.
    ///
    /// The Compute Optimizer API, Command Line Interface (CLI), and SDKs
    /// return utilization metrics using only the `Maximum` statistic, which is the
    /// highest value observed during the specified period.
    ///
    /// The Compute Optimizer console displays graphs for some utilization metrics
    /// using the
    /// `Average` statistic, which is the value of `Sum` /
    /// `SampleCount` during the specified period. For more information, see
    /// [Viewing resource
    /// recommendations](https://docs.aws.amazon.com/compute-optimizer/latest/ug/viewing-recommendations.html) in the *Compute Optimizer User
    /// Guide*. You can also get averaged utilization metric data for your resources
    /// using Amazon CloudWatch. For more information, see the [Amazon CloudWatch
    /// User
    /// Guide](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html).
    statistic: ?ECSServiceMetricStatistic = null,

    /// The upper bound values for the projected utilization metrics.
    upper_bound_value: f64 = 0,

    pub const json_field_names = .{
        .lower_bound_value = "lowerBoundValue",
        .name = "name",
        .statistic = "statistic",
        .upper_bound_value = "upperBoundValue",
    };
};
