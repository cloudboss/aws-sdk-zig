const LambdaDeviceMount = @import("lambda_device_mount.zig").LambdaDeviceMount;
const LambdaVolumeMount = @import("lambda_volume_mount.zig").LambdaVolumeMount;

/// Contains information about a container in which Lambda functions run on
/// Greengrass core
/// devices.
pub const LambdaContainerParams = struct {
    /// The list of system devices that the container can access.
    devices: ?[]const LambdaDeviceMount,

    /// The memory size of the container, expressed in kilobytes.
    ///
    /// Default: `16384` (16 MB)
    memory_size_in_kb: ?i32,

    /// Whether or not the container can read information from the device's `/sys`
    /// folder.
    ///
    /// Default: `false`
    mount_ro_sysfs: ?bool,

    /// The list of volumes that the container can access.
    volumes: ?[]const LambdaVolumeMount,

    pub const json_field_names = .{
        .devices = "devices",
        .memory_size_in_kb = "memorySizeInKB",
        .mount_ro_sysfs = "mountROSysfs",
        .volumes = "volumes",
    };
};
