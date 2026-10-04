const EphemeralEBSVolumeConfiguration = @import("ephemeral_ebs_volume_configuration.zig").EphemeralEBSVolumeConfiguration;

/// A block device mapping for an instance store (ephemeral) volume.
pub const EphemeralBlockDeviceMapping = struct {
    /// The device name, for example `/dev/sdh` or `xvdh`.
    device_name: ?[]const u8 = null,

    ebs: ?EphemeralEBSVolumeConfiguration = null,

    /// The virtual device name (`ephemeralN`). Instance store volumes are numbered
    /// starting from 0. The number of available instance store volumes depends on
    /// the instance type. After you connect to the instance, you must mount the
    /// volume.
    virtual_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .ebs = "ebs",
        .virtual_name = "virtualName",
    };
};
