const EbsInstanceBlockDevice = @import("ebs_instance_block_device.zig").EbsInstanceBlockDevice;

/// The description of a block device mapping.
pub const InstanceBlockDeviceMapping = struct {
    /// The block device name.
    device_name: ?[]const u8 = null,

    /// The parameters used to automatically set up Amazon Elastic Block Store
    /// (Amazon EBS)
    /// volumes when the instance is launched.
    ebs: ?EbsInstanceBlockDevice = null,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .ebs = "ebs",
    };
};
