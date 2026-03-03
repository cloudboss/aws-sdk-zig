const CoreDeviceStatus = @import("core_device_status.zig").CoreDeviceStatus;

/// Contains information about a Greengrass core device, which is an IoT thing
/// that runs the IoT Greengrass
/// Core software.
pub const CoreDevice = struct {
    /// The computer architecture of the core device.
    architecture: ?[]const u8 = null,

    /// The name of the core device. This is also the name of the IoT thing.
    core_device_thing_name: ?[]const u8 = null,

    /// The time at which the core device's status last updated, expressed in ISO
    /// 8601
    /// format.
    last_status_update_timestamp: ?i64 = null,

    /// The operating system platform that the core device runs.
    platform: ?[]const u8 = null,

    /// The runtime for the core device. The runtime can be:
    ///
    /// * `aws_nucleus_classic`
    ///
    /// * `aws_nucleus_lite`
    runtime: ?[]const u8 = null,

    /// The status of the core device. Core devices can have the following
    /// statuses:
    ///
    /// * `HEALTHY` – The IoT Greengrass Core software and all components run on the
    ///   core device without issue.
    ///
    /// * `UNHEALTHY` – The IoT Greengrass Core software or a component is in a
    ///   failed state
    /// on the core device.
    status: ?CoreDeviceStatus = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .core_device_thing_name = "coreDeviceThingName",
        .last_status_update_timestamp = "lastStatusUpdateTimestamp",
        .platform = "platform",
        .runtime = "runtime",
        .status = "status",
    };
};
