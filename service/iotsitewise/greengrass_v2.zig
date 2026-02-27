const CoreDeviceOperatingSystem = @import("core_device_operating_system.zig").CoreDeviceOperatingSystem;

/// Contains details for a gateway that runs on IoT Greengrass V2. To create a
/// gateway that runs on IoT Greengrass V2,
/// you must deploy the IoT SiteWise Edge component to your gateway device. Your
/// [Greengrass
/// device
/// role](https://docs.aws.amazon.com/greengrass/v2/developerguide/device-service-role.html) must use the `AWSIoTSiteWiseEdgeAccess` policy. For more
/// information, see [Using IoT SiteWise at the
/// edge](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/sw-gateways.html) in the
/// *IoT SiteWise User Guide*.
pub const GreengrassV2 = struct {
    /// The operating system of the core device in IoT Greengrass V2. Specifying the
    /// operating system is
    /// required for MQTT-enabled, V3 gateways (`gatewayVersion`
    /// `3`) and not applicable for Classic stream, V2 gateways
    /// (`gatewayVersion`
    /// `2`).
    core_device_operating_system: ?CoreDeviceOperatingSystem,

    /// The name of the IoT thing for your IoT Greengrass V2 core device.
    core_device_thing_name: []const u8,

    pub const json_field_names = .{
        .core_device_operating_system = "coreDeviceOperatingSystem",
        .core_device_thing_name = "coreDeviceThingName",
    };
};
