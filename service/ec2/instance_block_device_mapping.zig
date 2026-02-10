const EbsInstanceBlockDevice = @import("ebs_instance_block_device.zig").EbsInstanceBlockDevice;

/// Describes a block device mapping.
pub const InstanceBlockDeviceMapping = struct {
    /// The device name.
    device_name: ?[]const u8,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?EbsInstanceBlockDevice,
};
