const AutoScalingPolicy = @import("auto_scaling_policy.zig").AutoScalingPolicy;

/// The optional auto scaling settings for a table with provisioned throughput
/// capacity.
///
/// To turn on auto scaling for a table in `throughputMode:PROVISIONED`, you
/// must specify the following parameters.
///
/// Configure the minimum and maximum capacity units. The auto scaling policy
/// ensures that capacity never goes below the minimum or above the maximum
/// range.
///
/// * `minimumUnits`: The minimum level of throughput the table should always be
///   ready to support. The value must be between 1 and the max throughput per
///   second quota for your account (40,000 by default).
/// * `maximumUnits`: The maximum level of throughput the table should always be
///   ready to support. The value must be between 1 and the max throughput per
///   second quota for your account (40,000 by default).
/// * `scalingPolicy`: Amazon Keyspaces supports the `target tracking` scaling
///   policy. The auto scaling target is the provisioned capacity of the table.
///
/// * `targetTrackingScalingPolicyConfiguration`: To define the target tracking
///   policy, you must define the target value.
///
/// * `targetValue`: The target utilization rate of the table. Amazon Keyspaces
///   auto scaling ensures that the ratio of consumed capacity to provisioned
///   capacity stays at or near this value. You define `targetValue` as a
///   percentage. A `double` between 20 and 90. (Required)
/// * `disableScaleIn`: A `boolean` that specifies if `scale-in` is disabled or
///   enabled for the table. This parameter is disabled by default. To turn on
///   `scale-in`, set the `boolean` value to `FALSE`. This means that capacity
///   for a table can be automatically scaled down on your behalf. (Optional)
/// * `scaleInCooldown`: A cooldown period in seconds between scaling activities
///   that lets the table stabilize before another scale in activity starts. If
///   no value is provided, the default is 0. (Optional)
/// * `scaleOutCooldown`: A cooldown period in seconds between scaling
///   activities that lets the table stabilize before another scale out activity
///   starts. If no value is provided, the default is 0. (Optional)
///
/// For more information, see [Managing throughput capacity automatically with
/// Amazon Keyspaces auto
/// scaling](https://docs.aws.amazon.com/keyspaces/latest/devguide/autoscaling.html) in the *Amazon Keyspaces Developer Guide*.
pub const AutoScalingSettings = struct {
    /// This optional parameter enables auto scaling for the table if set to
    /// `false`.
    auto_scaling_disabled: bool = false,

    /// Manage costs by specifying the maximum amount of throughput to provision.
    /// The value must be between 1 and the max throughput per second quota for your
    /// account (40,000 by default).
    maximum_units: ?i64 = null,

    /// The minimum level of throughput the table should always be ready to support.
    /// The value must be between 1 and the max throughput per second quota for your
    /// account (40,000 by default).
    minimum_units: ?i64 = null,

    /// Amazon Keyspaces supports the `target tracking` auto scaling policy. With
    /// this policy, Amazon Keyspaces auto scaling ensures that the table's ratio of
    /// consumed to provisioned capacity stays at or near the target value that you
    /// specify. You define the target value as a percentage between 20 and 90.
    scaling_policy: ?AutoScalingPolicy = null,

    pub const json_field_names = .{
        .auto_scaling_disabled = "autoScalingDisabled",
        .maximum_units = "maximumUnits",
        .minimum_units = "minimumUnits",
        .scaling_policy = "scalingPolicy",
    };
};
