const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const MachineLearningDetectionConfig = @import("machine_learning_detection_config.zig").MachineLearningDetectionConfig;
const StatisticalThreshold = @import("statistical_threshold.zig").StatisticalThreshold;
const MetricValue = @import("metric_value.zig").MetricValue;

/// The criteria by which the behavior is determined to be normal.
pub const BehaviorCriteria = struct {
    /// The operator that relates the thing measured (`metric`) to the criteria
    /// (containing a `value` or `statisticalThreshold`). Valid operators include:
    ///
    /// * `string-list`: `in-set` and `not-in-set`
    ///
    /// * `number-list`: `in-set` and `not-in-set`
    ///
    /// * `ip-address-list`: `in-cidr-set` and `not-in-cidr-set`
    ///
    /// * `number`: `less-than`, `less-than-equals`, `greater-than`, and
    ///   `greater-than-equals`
    comparison_operator: ?ComparisonOperator = null,

    /// If a device is in violation of the behavior for the specified number of
    /// consecutive
    /// datapoints, an alarm occurs. If not specified, the default is 1.
    consecutive_datapoints_to_alarm: ?i32 = null,

    /// If an alarm has occurred and the offending device is no longer in violation
    /// of the behavior
    /// for the specified number of consecutive datapoints, the alarm is cleared. If
    /// not specified,
    /// the default is 1.
    consecutive_datapoints_to_clear: ?i32 = null,

    /// Use this to specify the time duration over which the behavior is evaluated,
    /// for those criteria that
    /// have a time dimension (for example, `NUM_MESSAGES_SENT`). For a
    /// `statisticalThreshhold` metric comparison, measurements from all devices are
    /// accumulated over this time duration before being used to calculate
    /// percentiles, and later,
    /// measurements from an individual device are also accumulated over this time
    /// duration before
    /// being given a percentile rank. Cannot be used with list-based metric
    /// datatypes.
    duration_seconds: ?i32 = null,

    /// The configuration of an ML Detect
    ml_detection_config: ?MachineLearningDetectionConfig = null,

    /// A statistical ranking (percentile)that
    /// indicates a threshold value by which a behavior is determined to be in
    /// compliance or in
    /// violation of the behavior.
    statistical_threshold: ?StatisticalThreshold = null,

    /// The value to be compared with the `metric`.
    value: ?MetricValue = null,

    pub const json_field_names = .{
        .comparison_operator = "comparisonOperator",
        .consecutive_datapoints_to_alarm = "consecutiveDatapointsToAlarm",
        .consecutive_datapoints_to_clear = "consecutiveDatapointsToClear",
        .duration_seconds = "durationSeconds",
        .ml_detection_config = "mlDetectionConfig",
        .statistical_threshold = "statisticalThreshold",
        .value = "value",
    };
};
