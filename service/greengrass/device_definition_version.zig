const Device = @import("device.zig").Device;

/// Information about a device definition version.
pub const DeviceDefinitionVersion = struct {
    /// A list of devices in the definition version.
    devices: ?[]const Device,

    pub const json_field_names = .{
        .devices = "Devices",
    };
};
