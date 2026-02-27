const ProjectedMetric = @import("projected_metric.zig").ProjectedMetric;

/// Describes a projected utilization metric of a recommendation option.
///
/// The `Cpu` and `Memory` metrics are the only projected
/// utilization metrics returned when you run the
/// GetEC2RecommendationProjectedMetrics action. Additionally, the
/// `Memory` metric is returned only for resources that have the unified
/// CloudWatch agent installed on them. For more information, see [Enabling
/// Memory Utilization with the CloudWatch
/// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent).
pub const RecommendedOptionProjectedMetric = struct {
    /// An array of objects that describe a projected utilization metric.
    projected_metrics: ?[]const ProjectedMetric,

    /// The rank of the recommendation option projected metric.
    ///
    /// The top recommendation option is ranked as `1`.
    ///
    /// The projected metric rank correlates to the recommendation option rank. For
    /// example,
    /// the projected metric ranked as `1` is related to the recommendation option
    /// that is also ranked as `1` in the same response.
    rank: i32 = 0,

    /// The recommended instance type.
    recommended_instance_type: ?[]const u8,

    pub const json_field_names = .{
        .projected_metrics = "projectedMetrics",
        .rank = "rank",
        .recommended_instance_type = "recommendedInstanceType",
    };
};
