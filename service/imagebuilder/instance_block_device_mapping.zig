const EbsInstanceBlockDeviceSpecification = @import("ebs_instance_block_device_specification.zig").EbsInstanceBlockDeviceSpecification;

/// Defines block device mappings for the instance used to configure your image.
pub const InstanceBlockDeviceMapping = struct {
    /// The device to which these mappings apply.
    device_name: ?[]const u8 = null,

    /// The Amazon EBS-specific configuration for this mapping.
    ebs: ?EbsInstanceBlockDeviceSpecification = null,

    /// Specifies a mapping to remove from the base image.
    no_device: ?[]const u8 = null,

    /// The virtual device name for instance ephemeral devices.
    virtual_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_name = "deviceName",
        .ebs = "ebs",
        .no_device = "noDevice",
        .virtual_name = "virtualName",
    };
};
