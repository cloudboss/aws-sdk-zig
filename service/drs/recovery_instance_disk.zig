/// An object representing a block storage device on the Recovery Instance.
pub const RecoveryInstanceDisk = struct {
    /// The amount of storage on the disk in bytes.
    bytes: i64 = 0,

    /// The EBS Volume ID of this disk.
    ebs_volume_id: ?[]const u8 = null,

    /// The internal device name of this disk. This is the name that is visible on
    /// the machine itself and not from the EC2 console.
    internal_device_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "bytes",
        .ebs_volume_id = "ebsVolumeID",
        .internal_device_name = "internalDeviceName",
    };
};
