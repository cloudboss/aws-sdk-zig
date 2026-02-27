const SnowconeDeviceConfiguration = @import("snowcone_device_configuration.zig").SnowconeDeviceConfiguration;

/// The container for `SnowconeDeviceConfiguration`.
pub const DeviceConfiguration = struct {
    /// Returns information about the device configuration for an Snowball Edge
    /// job.
    snowcone_device_configuration: ?SnowconeDeviceConfiguration,

    pub const json_field_names = .{
        .snowcone_device_configuration = "SnowconeDeviceConfiguration",
    };
};
