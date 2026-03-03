const VolumeType = @import("volume_type.zig").VolumeType;

/// Describes a block device for an EBS volume.
pub const LaunchTemplateEbsBlockDevice = struct {
    /// Indicates whether the EBS volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// The index of the EBS card. Some instance types support multiple EBS cards.
    /// The default EBS card index is 0.
    ebs_card_index: ?i32 = null,

    /// Indicates whether the EBS volume is encrypted.
    encrypted: ?bool = null,

    /// The number of I/O operations per second (IOPS) that the volume supports.
    iops: ?i32 = null,

    /// Identifier (key ID, key alias, key ARN, or alias ARN) of the customer
    /// managed KMS key to use for EBS encryption.
    kms_key_id: ?[]const u8 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    /// The throughput that the volume supports, in MiB/s.
    throughput: ?i32 = null,

    /// The Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate) specified for the volume, in MiB/s.
    /// If no volume initialization rate was specified, the value is `null`.
    volume_initialization_rate: ?i32 = null,

    /// The size of the volume, in GiB.
    volume_size: ?i32 = null,

    /// The volume type.
    volume_type: ?VolumeType = null,
};
