const ConditionBasedSignalFetchConfig = @import("condition_based_signal_fetch_config.zig").ConditionBasedSignalFetchConfig;
const TimeBasedSignalFetchConfig = @import("time_based_signal_fetch_config.zig").TimeBasedSignalFetchConfig;

/// The configuration of the signal fetch operation.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const SignalFetchConfig = union(enum) {
    /// The configuration of a condition-based signal fetch operation.
    condition_based: ?ConditionBasedSignalFetchConfig,
    /// The configuration of a time-based signal fetch operation.
    time_based: ?TimeBasedSignalFetchConfig,

    pub const json_field_names = .{
        .condition_based = "conditionBased",
        .time_based = "timeBased",
    };
};
