const EbsInstanceBlockDeviceSpecification = @import("ebs_instance_block_device_specification.zig").EbsInstanceBlockDeviceSpecification;

/// Describes a block device mapping entry.
pub const InstanceBlockDeviceMappingSpecification = struct {
    /// The device name. For available device names, see [Device names for
    /// volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html).
    device_name: ?[]const u8,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?EbsInstanceBlockDeviceSpecification,

    /// Suppresses the specified device included in the block device mapping.
    no_device: ?[]const u8,

    /// The virtual device name.
    virtual_name: ?[]const u8,
};
