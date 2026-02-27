const IdleMetricName = @import("idle_metric_name.zig").IdleMetricName;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;

/// Describes the utilization metric of an idle resource.
pub const IdleUtilizationMetric = struct {
    /// The name of the utilization metric.
    name: ?IdleMetricName,

    /// The statistic of the utilization metric.
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
    statistic: ?MetricStatistic,

    /// The value of the utilization metric.
    value: f64 = 0,

    pub const json_field_names = .{
        .name = "name",
        .statistic = "statistic",
        .value = "value",
    };
};
