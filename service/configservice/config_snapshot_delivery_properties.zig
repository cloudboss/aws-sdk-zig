const MaximumExecutionFrequency = @import("maximum_execution_frequency.zig").MaximumExecutionFrequency;

/// Provides options for how often Config delivers
/// configuration snapshots to the Amazon S3 bucket in your delivery
/// channel.
///
/// The frequency for a rule that triggers evaluations for your
/// resources when Config delivers the configuration snapshot is set
/// by one of two values, depending on which is less frequent:
///
/// * The value for the `deliveryFrequency`
/// parameter within the delivery channel configuration, which
/// sets how often Config delivers configuration snapshots.
/// This value also sets how often Config invokes
/// evaluations for Config rules.
///
/// * The value for the
/// `MaximumExecutionFrequency` parameter, which
/// sets the maximum frequency with which Config invokes
/// evaluations for the rule. For more information, see ConfigRule.
///
/// If the `deliveryFrequency` value is less frequent
/// than the `MaximumExecutionFrequency` value for a rule,
/// Config invokes the rule only as often as the
/// `deliveryFrequency` value.
///
/// * For example, you want your rule to run evaluations when
/// Config delivers the configuration snapshot.
///
/// * You specify the `MaximumExecutionFrequency`
/// value for `Six_Hours`.
///
/// * You then specify the delivery channel
/// `deliveryFrequency` value for
/// `TwentyFour_Hours`.
///
/// * Because the value for `deliveryFrequency` is
/// less frequent than `MaximumExecutionFrequency`,
/// Config invokes evaluations for the rule every 24 hours.
///
/// You should set the `MaximumExecutionFrequency` value
/// to be at least as frequent as the `deliveryFrequency`
/// value. You can view the `deliveryFrequency` value by
/// using the `DescribeDeliveryChannnels` action.
///
/// To update the `deliveryFrequency` with which Config delivers your
/// configuration snapshots, use the
/// `PutDeliveryChannel` action.
pub const ConfigSnapshotDeliveryProperties = struct {
    /// The frequency with which Config delivers configuration
    /// snapshots.
    delivery_frequency: ?MaximumExecutionFrequency,

    pub const json_field_names = .{
        .delivery_frequency = "deliveryFrequency",
    };
};
