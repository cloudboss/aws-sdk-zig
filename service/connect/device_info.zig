/// Information regarding the device.
pub const DeviceInfo = struct {
    /// Operating system that the participant used for the call.
    operating_system: ?[]const u8,

    /// Name of the platform that the participant used for the call.
    platform_name: ?[]const u8,

    /// Version of the platform that the participant used for the call.
    platform_version: ?[]const u8,

    pub const json_field_names = .{
        .operating_system = "OperatingSystem",
        .platform_name = "PlatformName",
        .platform_version = "PlatformVersion",
    };
};
