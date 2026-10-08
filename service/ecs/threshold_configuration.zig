const ThresholdType = @import("threshold_type.zig").ThresholdType;

/// Defines the failure threshold that the deployment circuit breaker uses to
/// monitor a deployment. The `type` and `value` together determine the number
/// of task failures that are tolerated before the circuit breaker triggers.
///
/// By default, the threshold configuration uses a `type` of `BOUNDED_PERCENT`
/// with a `value` of `50`.
pub const ThresholdConfiguration = struct {
    /// Determines how Amazon ECS uses `value` to calculate the failure threshold.
    /// For the percentage types (`BOUNDED_PERCENT` and `UNBOUNDED_PERCENT`), Amazon
    /// ECS multiplies `value` by the latest service desired count. For `COUNT`,
    /// Amazon ECS uses `value` directly as the threshold. The default is
    /// `BOUNDED_PERCENT`.
    type: ThresholdType,

    /// Specifies the integer that Amazon ECS uses to calculate the failure
    /// threshold. When `type` is `COUNT`, this value is the failure threshold
    /// itself. When `type` is a percentage type, Amazon ECS multiplies this value
    /// by the latest service desired count to produce the failure threshold. The
    /// default is `50`.
    value: i32 = 0,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
