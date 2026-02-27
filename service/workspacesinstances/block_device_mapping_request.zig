const EbsBlockDevice = @import("ebs_block_device.zig").EbsBlockDevice;

/// Defines device mapping for WorkSpace Instance storage.
pub const BlockDeviceMappingRequest = struct {
    /// Name of the device for storage mapping.
    device_name: ?[]const u8,

    /// EBS volume configuration for the device.
    ebs: ?EbsBlockDevice,

    /// Indicates device should not be mapped.
    no_device: ?[]const u8,

    /// Virtual device name for ephemeral storage.
    virtual_name: ?[]const u8,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .ebs = "Ebs",
        .no_device = "NoDevice",
        .virtual_name = "VirtualName",
    };
};
