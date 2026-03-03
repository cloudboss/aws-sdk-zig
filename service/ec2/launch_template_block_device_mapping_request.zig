const LaunchTemplateEbsBlockDeviceRequest = @import("launch_template_ebs_block_device_request.zig").LaunchTemplateEbsBlockDeviceRequest;

/// Describes a block device mapping.
pub const LaunchTemplateBlockDeviceMappingRequest = struct {
    /// The device name (for example, /dev/sdh or xvdh).
    device_name: ?[]const u8 = null,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?LaunchTemplateEbsBlockDeviceRequest = null,

    /// To omit the device from the block device mapping, specify an empty string.
    no_device: ?[]const u8 = null,

    /// The virtual device name (ephemeralN). Instance store volumes are numbered
    /// starting
    /// from 0. An instance type with 2 available instance store volumes can specify
    /// mappings
    /// for ephemeral0 and ephemeral1. The number of available instance store
    /// volumes depends on
    /// the instance type. After you connect to the instance, you must mount the
    /// volume.
    virtual_name: ?[]const u8 = null,
};
