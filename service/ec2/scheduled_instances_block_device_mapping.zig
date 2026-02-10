const ScheduledInstancesEbs = @import("scheduled_instances_ebs.zig").ScheduledInstancesEbs;

/// Describes a block device mapping for a Scheduled Instance.
pub const ScheduledInstancesBlockDeviceMapping = struct {
    /// The device name (for example, `/dev/sdh` or `xvdh`).
    device_name: ?[]const u8,

    /// Parameters used to set up EBS volumes automatically when the instance is
    /// launched.
    ebs: ?ScheduledInstancesEbs,

    /// To omit the device from the block device mapping, specify an empty string.
    no_device: ?[]const u8,

    /// The virtual device name (`ephemeral`N). Instance store volumes are numbered
    /// starting from 0. An instance type with two available instance store volumes
    /// can specify mappings
    /// for `ephemeral0` and `ephemeral1`. The number of available instance store
    /// volumes depends on the instance type. After you connect to the instance, you
    /// must mount the
    /// volume.
    ///
    /// Constraints: For M3 instances, you must specify instance store volumes in
    /// the block device
    /// mapping for the instance. When you launch an M3 instance, we ignore any
    /// instance store volumes
    /// specified in the block device mapping for the AMI.
    virtual_name: ?[]const u8,
};
