/// Information about the instances to which the volume is attached.
pub const VolumeStatusAttachmentStatus = struct {
    /// The ID of the attached instance.
    instance_id: ?[]const u8,

    /// The maximum IOPS supported by the attached instance.
    io_performance: ?[]const u8,
};
