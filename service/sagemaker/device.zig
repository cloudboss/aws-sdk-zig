/// Information of a particular device.
pub const Device = struct {
    /// Description of the device.
    description: ?[]const u8,

    /// The name of the device.
    device_name: []const u8,

    /// Amazon Web Services Internet of Things (IoT) object name.
    iot_thing_name: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .device_name = "DeviceName",
        .iot_thing_name = "IotThingName",
    };
};
