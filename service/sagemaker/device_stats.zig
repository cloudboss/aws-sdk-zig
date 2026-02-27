/// Status of devices.
pub const DeviceStats = struct {
    /// The number of devices connected with a heartbeat.
    connected_device_count: i64,

    /// The number of registered devices.
    registered_device_count: i64,

    pub const json_field_names = .{
        .connected_device_count = "ConnectedDeviceCount",
        .registered_device_count = "RegisteredDeviceCount",
    };
};
