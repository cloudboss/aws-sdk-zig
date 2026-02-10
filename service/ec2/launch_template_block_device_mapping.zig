const LaunchTemplateEbsBlockDevice = @import("launch_template_ebs_block_device.zig").LaunchTemplateEbsBlockDevice;

/// Describes a block device mapping.
pub const LaunchTemplateBlockDeviceMapping = struct {
    /// The device name.
    device_name: ?[]const u8,

    /// Information about the block device for an EBS volume.
    ebs: ?LaunchTemplateEbsBlockDevice,

    /// To omit the device from the block device mapping, specify an empty string.
    no_device: ?[]const u8,

    /// The virtual device name (ephemeralN).
    virtual_name: ?[]const u8,
};
