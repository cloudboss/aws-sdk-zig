const VolumeType = @import("volume_type.zig").VolumeType;

/// The parameters for a block device for an EBS volume.
pub const LaunchTemplateEbsBlockDeviceRequest = struct {
    /// Indicates whether the EBS volume is deleted on instance termination.
    delete_on_termination: ?bool,

    /// The index of the EBS card. Some instance types support multiple EBS cards.
    /// The default EBS card index is 0.
    ebs_card_index: ?i32,

    /// Indicates whether the EBS volume is encrypted. Encrypted volumes can only be
    /// attached
    /// to instances that support Amazon EBS encryption. If you are creating a
    /// volume from a
    /// snapshot, you can't specify an encryption value.
    encrypted: ?bool,

    /// The number of I/O operations per second (IOPS). For `gp3`,
    /// `io1`, and `io2` volumes, this represents the number of IOPS that
    /// are provisioned for the volume. For `gp2` volumes, this represents the
    /// baseline performance of the volume and the rate at which the volume
    /// accumulates I/O
    /// credits for bursting.
    ///
    /// The following are the supported values for each volume type:
    ///
    /// * `gp3`: 3,000 - 80,000 IOPS
    ///
    /// * `io1`: 100 - 64,000 IOPS
    ///
    /// * `io2`: 100 - 256,000 IOPS
    ///
    /// For `io2` volumes, you can achieve up to 256,000 IOPS on
    /// [instances
    /// built on the Nitro
    /// System](https://docs.aws.amazon.com/ec2/latest/instancetypes/ec2-nitro-instances.html). On other instances, you can achieve performance up to 32,000 IOPS.
    ///
    /// This parameter is supported for `io1`, `io2`, and `gp3` volumes only.
    iops: ?i32,

    /// Identifier (key ID, key alias, key ARN, or alias ARN) of the customer
    /// managed KMS key to use for EBS encryption.
    kms_key_id: ?[]const u8,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,

    /// The throughput to provision for a `gp3` volume, with a maximum of 2,000
    /// MiB/s.
    ///
    /// Valid Range: Minimum value of 125. Maximum value of 2,000.
    throughput: ?i32,

    /// Specifies the Amazon EBS Provisioned Rate for Volume Initialization (volume
    /// initialization rate), in MiB/s, at which to download
    /// the snapshot blocks from Amazon S3 to the volume. This is also known as
    /// *volume
    /// initialization*. Specifying a volume initialization rate ensures that the
    /// volume is
    /// initialized at a predictable and consistent rate after creation.
    ///
    /// This parameter is supported only for volumes created from snapshots. Omit
    /// this parameter
    /// if:
    ///
    /// * You want to create the volume using fast snapshot restore. You must
    ///   specify a snapshot
    /// that is enabled for fast snapshot restore. In this case, the volume is fully
    /// initialized
    /// at creation.
    ///
    /// **Note:**
    ///
    /// If you specify a snapshot that is enabled for fast snapshot restore and a
    /// volume initialization rate,
    /// the volume will be initialized at the specified rate instead of fast
    /// snapshot restore.
    ///
    /// * You want to create a volume that is initialized at the default rate.
    ///
    /// For more information, see [
    /// Initialize Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html) in the *Amazon EC2 User Guide*.
    ///
    /// Valid range: 100 - 300 MiB/s
    volume_initialization_rate: ?i32,

    /// The size of the volume, in GiBs. You must specify either a snapshot ID or a
    /// volume
    /// size. The following are the supported volumes sizes for each volume type:
    ///
    /// * `gp2`: 1 - 16,384 GiB
    ///
    /// * `gp3`: 1 - 65,536 GiB
    ///
    /// * `io1`: 4 - 16,384 GiB
    ///
    /// * `io2`: 4 - 65,536 GiB
    ///
    /// * `st1` and `sc1`: 125 - 16,384 GiB
    ///
    /// * `standard`: 1 - 1024 GiB
    volume_size: ?i32,

    /// The volume type. For more information, see [Amazon EBS volume
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volume-types.html) in the
    /// *Amazon EBS User Guide*.
    volume_type: ?VolumeType,
};
