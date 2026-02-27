const StorageMaximumSizeUnit = @import("storage_maximum_size_unit.zig").StorageMaximumSizeUnit;

/// The maximum storage size for the data partition.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const StorageMaximumSize = struct {
    /// The data type of the data to store.
    unit: StorageMaximumSizeUnit,

    /// The maximum amount of time to store data.
    value: i32,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
