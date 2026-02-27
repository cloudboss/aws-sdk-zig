const AutoScalingMetric = @import("auto_scaling_metric.zig").AutoScalingMetric;

/// The configuration based on which FinSpace will scale in or scale out nodes
/// in your cluster.
pub const AutoScalingConfiguration = struct {
    /// The metric your cluster will track in order to scale in and out. For
    /// example, `CPU_UTILIZATION_PERCENTAGE` is the average CPU usage across all
    /// the nodes in a cluster.
    auto_scaling_metric: ?AutoScalingMetric,

    /// The highest number of nodes to scale. This value cannot be greater than 5.
    max_node_count: ?i32,

    /// The desired value of the chosen `autoScalingMetric`. When the metric drops
    /// below this value, the cluster will scale in. When the metric goes above this
    /// value, the cluster will scale out. You can set the target value between 1
    /// and 100 percent.
    metric_target: ?f64,

    /// The lowest number of nodes to scale. This value must be at least 1 and less
    /// than the `maxNodeCount`. If the nodes in a cluster belong to multiple
    /// availability zones, then `minNodeCount` must be at least 3.
    min_node_count: ?i32,

    /// The duration in seconds that FinSpace will wait after a scale in event
    /// before initiating another scaling event.
    scale_in_cooldown_seconds: ?f64,

    /// The duration in seconds that FinSpace will wait after a scale out event
    /// before initiating another scaling event.
    scale_out_cooldown_seconds: ?f64,

    pub const json_field_names = .{
        .auto_scaling_metric = "autoScalingMetric",
        .max_node_count = "maxNodeCount",
        .metric_target = "metricTarget",
        .min_node_count = "minNodeCount",
        .scale_in_cooldown_seconds = "scaleInCooldownSeconds",
        .scale_out_cooldown_seconds = "scaleOutCooldownSeconds",
    };
};
