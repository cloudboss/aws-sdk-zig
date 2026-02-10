const EbsBlockDeviceResponse = @import("ebs_block_device_response.zig").EbsBlockDeviceResponse;

/// Describes a block device mapping, which defines the EBS volumes and instance
/// store
/// volumes to attach to an instance at launch.
pub const BlockDeviceMappingResponse = struct {
    /// The device name (for example, `/dev/sdh` or `xvdh`).
    device_name: ?[]const u8,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?EbsBlockDeviceResponse,

    /// Suppresses the specified device included in the block device mapping.
    no_device: ?[]const u8,

    /// The virtual device name.
    virtual_name: ?[]const u8,
};
