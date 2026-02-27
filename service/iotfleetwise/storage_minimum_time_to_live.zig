const StorageMinimumTimeToLiveUnit = @import("storage_minimum_time_to_live_unit.zig").StorageMinimumTimeToLiveUnit;

/// Information about the minimum amount of time that data will be kept.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const StorageMinimumTimeToLive = struct {
    /// The time increment type.
    unit: StorageMinimumTimeToLiveUnit,

    /// The minimum amount of time to store the data.
    value: i32,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
