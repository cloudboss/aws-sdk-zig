const VolumeTypeEnum = @import("volume_type_enum.zig").VolumeTypeEnum;

/// Defines configuration for an Elastic Block Store volume.
pub const EbsBlockDevice = struct {
    /// Indicates if the volume is encrypted.
    encrypted: ?bool = null,

    /// Input/output operations per second for the volume.
    iops: ?i32 = null,

    /// KMS key used for volume encryption.
    kms_key_id: ?[]const u8 = null,

    /// Volume data transfer rate.
    throughput: ?i32 = null,

    /// Size of the EBS volume in gigabytes.
    volume_size: ?i32 = null,

    /// Type of EBS volume (e.g., gp2, io1).
    volume_type: ?VolumeTypeEnum = null,

    pub const json_field_names = .{
        .encrypted = "Encrypted",
        .iops = "Iops",
        .kms_key_id = "KmsKeyId",
        .throughput = "Throughput",
        .volume_size = "VolumeSize",
        .volume_type = "VolumeType",
    };
};
