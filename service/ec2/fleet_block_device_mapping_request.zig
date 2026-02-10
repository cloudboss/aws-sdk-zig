const FleetEbsBlockDeviceRequest = @import("fleet_ebs_block_device_request.zig").FleetEbsBlockDeviceRequest;

/// Describes a block device mapping, which defines the EBS volumes and instance
/// store
/// volumes to attach to an instance at launch.
///
/// To override a block device mapping specified in the launch template:
///
/// * Specify the exact same `DeviceName` here as specified in the launch
/// template.
///
/// * Only specify the parameters you want to change.
///
/// * Any parameters you don't specify here will keep their original launch
///   template
/// values.
///
/// To add a new block device mapping:
///
/// * Specify a `DeviceName` that doesn't exist in the launch
/// template.
///
/// * Specify all desired parameters here.
pub const FleetBlockDeviceMappingRequest = struct {
    /// The device name (for example, `/dev/sdh` or `xvdh`).
    device_name: ?[]const u8,

    /// Parameters used to automatically set up EBS volumes when the instance is
    /// launched.
    ebs: ?FleetEbsBlockDeviceRequest,

    /// To omit the device from the block device mapping, specify an empty string.
    /// When this
    /// property is specified, the device is removed from the block device mapping
    /// regardless of
    /// the assigned value.
    no_device: ?[]const u8,

    /// The virtual device name (`ephemeralN`). Instance store volumes are numbered
    /// starting from 0. An instance type with 2 available instance store volumes
    /// can specify
    /// mappings for `ephemeral0` and `ephemeral1`. The number of available
    /// instance store volumes depends on the instance type. After you connect to
    /// the instance, you
    /// must mount the volume.
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
