const MetricName = @import("metric_name.zig").MetricName;

/// Describes a projected utilization metric of a recommendation option, such as
/// an
/// Amazon EC2 instance. This represents the projected utilization of a
/// recommendation option had you used that resource during the analyzed period.
///
/// Compare the utilization metric data of your resource against its projected
/// utilization
/// metric data to determine the performance difference between your current
/// resource and
/// the recommended option.
///
/// The `Cpu`, `Memory`, `GPU`, and `GPU_MEMORY` metrics
/// are the only projected utilization metrics returned when you run the
/// GetEC2RecommendationProjectedMetrics action. Additionally, these
/// metrics are only returned for resources with the unified
/// CloudWatch agent installed on them. For more information, see [Enabling
/// Memory Utilization with the CloudWatch
/// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent) and
/// [Enabling NVIDIA GPU
/// utilization with the CloudWatch
/// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#nvidia-cw-agent).
pub const ProjectedMetric = struct {
    /// The name of the projected utilization metric.
    ///
    /// The following projected utilization metrics are returned:
    ///
    /// * `Cpu` - The projected percentage of allocated EC2 compute units
    /// that would be in use on the recommendation option had you used that resource
    /// during the analyzed period. This metric identifies the processing power
    /// required
    /// to run an application on the recommendation option.
    ///
    /// Depending on the instance type, tools in your operating system can show a
    /// lower percentage than CloudWatch when the instance is not allocated a full
    /// processor core.
    ///
    /// * `Memory` - The percentage of memory that would be in use on the
    /// recommendation option had you used that resource during the analyzed period.
    /// This metric identifies the amount of memory required to run an application
    /// on
    /// the recommendation option.
    ///
    /// Units: Percent
    ///
    /// The `Memory` metric is only returned for resources with
    /// the unified CloudWatch agent installed on them. For more information,
    /// see [Enabling Memory
    /// Utilization with the CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#cw-agent).
    ///
    /// * `GPU` - The projected percentage of allocated GPUs if you adjust your
    /// configurations to Compute Optimizer's recommendation option.
    ///
    /// * `GPU_MEMORY` - The projected percentage of total GPU memory if you adjust
    ///   your
    /// configurations to Compute Optimizer's recommendation option.
    ///
    /// The `GPU` and `GPU_MEMORY` metrics are only returned for resources
    /// with the unified CloudWatch Agent installed on them. For more information,
    /// see
    /// [Enabling NVIDIA GPU
    /// utilization with the CloudWatch
    /// Agent](https://docs.aws.amazon.com/compute-optimizer/latest/ug/metrics.html#nvidia-cw-agent).
    name: ?MetricName,

    /// The timestamps of the projected utilization metric.
    timestamps: ?[]const i64,

    /// The values of the projected utilization metrics.
    values: ?[]const f64,

    pub const json_field_names = .{
        .name = "name",
        .timestamps = "timestamps",
        .values = "values",
    };
};
