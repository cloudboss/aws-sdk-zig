/// EBS block device that's attached to an Amazon EC2 instance.
pub const EbsVolume = struct {
    /// The device name that is exposed to the instance, such as /dev/sdh.
    device: ?[]const u8 = null,

    /// The volume identifier of the EBS volume.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .device = "Device",
        .volume_id = "VolumeId",
    };
};
