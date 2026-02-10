const EbsBlockDevice = @import("ebs_block_device.zig").EbsBlockDevice;

/// Describes a block device mapping, which defines the EBS volumes and instance
/// store
/// volumes to attach to an instance at launch.
pub const BlockDeviceMapping = struct {
    /// The device name. For available device names, see [Device names for
    /// volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html).
    device_name: ?[]const u8,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?EbsBlockDevice,

    /// To omit the device from the block device mapping, specify an empty string.
    /// When this
    /// property is specified, the device is removed from the block device mapping
    /// regardless of
    /// the assigned value.
    no_device: ?[]const u8,

    /// The virtual device name (`ephemeral`N). Instance store volumes are numbered
    /// starting from 0. An instance type with 2 available instance store volumes
    /// can specify
    /// mappings for `ephemeral0` and `ephemeral1`. The number of
    /// available instance store volumes depends on the instance type. After you
    /// connect to the
    /// instance, you must mount the volume.
    ///
    /// NVMe instance store volumes are automatically enumerated and assigned a
    /// device name.
    /// Including them in your block device mapping has no effect.
    ///
    /// Constraints: For M3 instances, you must specify instance store volumes in
    /// the block
    /// device mapping for the instance. When you launch an M3 instance, we ignore
    /// any instance
    /// store volumes specified in the block device mapping for the AMI.
    virtual_name: ?[]const u8,
};
