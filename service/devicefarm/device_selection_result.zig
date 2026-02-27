const DeviceFilter = @import("device_filter.zig").DeviceFilter;

/// Contains the run results requested by the device selection configuration and
/// how many devices were
/// returned. For an example of the JSON response syntax, see ScheduleRun.
pub const DeviceSelectionResult = struct {
    /// The filters in a device selection result.
    filters: ?[]const DeviceFilter,

    /// The number of devices that matched the device filter selection criteria.
    matched_devices_count: ?i32,

    /// The maximum number of devices to be selected by a device filter and included
    /// in a test
    /// run.
    max_devices: ?i32,

    pub const json_field_names = .{
        .filters = "filters",
        .matched_devices_count = "matchedDevicesCount",
        .max_devices = "maxDevices",
    };
};
