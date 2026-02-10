const VolumeType = @import("volume_type.zig").VolumeType;

/// Describes a block device for an EBS volume.
pub const EbsBlockDeviceResponse = struct {
    /// Indicates whether the volume is deleted on instance termination.
    delete_on_termination: ?bool,

    /// Indicates whether the volume is encrypted.
    encrypted: ?bool,

    /// The number of I/O operations per second (IOPS). For `gp3`, `io1`, and `io2`
    /// volumes,
    /// this represents the number of IOPS that are provisioned for the volume. For
    /// `gp2`
    /// volumes, this represents the baseline performance of the volume and the rate
    /// at which
    /// the volume accumulates I/O credits for bursting.
    iops: ?i32,

    /// Identifier (key ID, key alias, key ARN, or alias ARN) of the customer
    /// managed KMS key
    /// to use for EBS encryption.
    kms_key_id: ?[]const u8,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,

    /// The throughput that the volume supports, in MiB/s.
    throughput: ?i32,

    /// The size of the volume, in GiBs.
    volume_size: ?i32,

    /// The volume type. For more information, see [Amazon EBS volume
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html) in the
    /// *Amazon EBS User Guide*.
    volume_type: ?VolumeType,
};
