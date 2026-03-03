const BatteryLevel = @import("battery_level.zig").BatteryLevel;
const DeviceState = @import("device_state.zig").DeviceState;
const Event = @import("event.zig").Event;

/// MetaData for Sidewalk device.
pub const SidewalkDeviceMetadata = struct {
    /// Sidewalk device battery level.
    battery_level: ?BatteryLevel = null,

    /// Device state defines the device status of sidewalk device.
    device_state: ?DeviceState = null,

    /// Sidewalk device status notification.
    event: ?Event = null,

    /// The RSSI value.
    rssi: ?i32 = null,

    pub const json_field_names = .{
        .battery_level = "BatteryLevel",
        .device_state = "DeviceState",
        .event = "Event",
        .rssi = "Rssi",
    };
};
