/// Describes a storage volume recovery point object.
pub const VolumeRecoveryPointInfo = struct {
    /// The Amazon Resource Name (ARN) of the volume target.
    volume_arn: ?[]const u8,

    /// The time the recovery point was taken.
    volume_recovery_point_time: ?[]const u8,

    /// The size of the volume in bytes.
    volume_size_in_bytes: i64 = 0,

    /// The size of the data stored on the volume in bytes.
    ///
    /// This value is not available for volumes created prior to May 13, 2015, until
    /// you
    /// store data on the volume.
    volume_usage_in_bytes: i64 = 0,

    pub const json_field_names = .{
        .volume_arn = "VolumeARN",
        .volume_recovery_point_time = "VolumeRecoveryPointTime",
        .volume_size_in_bytes = "VolumeSizeInBytes",
        .volume_usage_in_bytes = "VolumeUsageInBytes",
    };
};
