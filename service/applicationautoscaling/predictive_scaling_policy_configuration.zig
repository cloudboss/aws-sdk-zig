const PredictiveScalingMaxCapacityBreachBehavior = @import("predictive_scaling_max_capacity_breach_behavior.zig").PredictiveScalingMaxCapacityBreachBehavior;
const PredictiveScalingMetricSpecification = @import("predictive_scaling_metric_specification.zig").PredictiveScalingMetricSpecification;
const PredictiveScalingMode = @import("predictive_scaling_mode.zig").PredictiveScalingMode;

/// Represents a predictive scaling policy configuration. Predictive scaling is
/// supported on Amazon ECS services.
pub const PredictiveScalingPolicyConfiguration = struct {
    /// Defines the behavior that should be applied if the forecast capacity
    /// approaches or
    /// exceeds the maximum capacity. Defaults to
    /// `HonorMaxCapacity` if not specified.
    max_capacity_breach_behavior: ?PredictiveScalingMaxCapacityBreachBehavior = null,

    /// The size of the capacity buffer to use when the forecast capacity is close
    /// to or
    /// exceeds the maximum capacity. The value is specified as a percentage
    /// relative to the
    /// forecast capacity. For example, if the buffer is 10, this means a 10 percent
    /// buffer,
    /// such that if the forecast capacity is 50, and the maximum capacity is 40,
    /// then the
    /// effective maximum capacity is 55.
    ///
    /// Required if the `MaxCapacityBreachBehavior` property is set to
    /// `IncreaseMaxCapacity`, and cannot be used otherwise.
    max_capacity_buffer: ?i32 = null,

    /// This structure includes the metrics and target utilization to use for
    /// predictive scaling.
    ///
    /// This is an array, but we currently only support a single metric
    /// specification. That
    /// is, you can specify a target value and a single metric pair, or a target
    /// value and one
    /// scaling metric and one load metric.
    metric_specifications: []const PredictiveScalingMetricSpecification,

    /// The predictive scaling mode. Defaults to `ForecastOnly` if not specified.
    mode: ?PredictiveScalingMode = null,

    /// The amount of time, in seconds, that the start time can be advanced.
    ///
    /// The value must be less than the forecast interval duration of 3600 seconds
    /// (60
    /// minutes). Defaults to 300 seconds if not specified.
    scheduling_buffer_time: ?i32 = null,

    pub const json_field_names = .{
        .max_capacity_breach_behavior = "MaxCapacityBreachBehavior",
        .max_capacity_buffer = "MaxCapacityBuffer",
        .metric_specifications = "MetricSpecifications",
        .mode = "Mode",
        .scheduling_buffer_time = "SchedulingBufferTime",
    };
};
