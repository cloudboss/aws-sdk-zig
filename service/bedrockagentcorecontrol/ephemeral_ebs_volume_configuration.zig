const EbsVolumeType = @import("ebs_volume_type.zig").EbsVolumeType;

/// The shared Amazon EBS performance and encryption properties for a volume.
/// These properties are common across the different volume configurations for a
/// capacity provider.
pub const EphemeralEBSVolumeConfiguration = struct {
    /// The index of the Amazon EBS card. Applies to instances with multiple Amazon
    /// EBS cards.
    ebs_card_index: ?i32 = null,

    /// Specifies whether to encrypt the volume. Encrypted volumes can be attached
    /// only to instances that support Amazon EBS encryption. If you create a volume
    /// from a snapshot, you cannot specify an encryption value.
    encrypted: ?bool = null,

    /// The number of IOPS to provision. For `gp3`, `io1`, and `io2` volumes, this
    /// is the number of IOPS provisioned for the volume. For `gp2` volumes, this
    /// sets the baseline IOPS performance. It also controls the rate at which the
    /// volume accumulates I/O credits for bursting. Supported values: `gp3`,
    /// 3,000–80,000; `io1`, 100–64,000; `io2`, 100–256,000.
    iops: ?i32 = null,

    /// The identifier (key ID, key alias, key ARN, or alias ARN) of the customer
    /// managed KMS key to use for Amazon EBS encryption.
    kms_key_id: ?[]const u8 = null,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8 = null,

    /// The throughput to provision, in MiB/s. Valid only for `gp3` volumes. Valid
    /// range: 125–2,000 MiB/s.
    throughput: ?i32 = null,

    /// The rate at which the volume is initialized after creation, in MiB/s.
    /// Supported only for volumes created from snapshots. Valid range: 100–300
    /// MiB/s.
    volume_initialization_rate: ?i32 = null,

    /// The size of the volume, in GiB. You must specify either a snapshot ID or a
    /// volume size. Supported sizes: `gp2`, 1–16,384; `gp3`, 1–65,536; `io1`,
    /// 4–16,384; `io2`, 4–65,536.
    volume_size: ?i32 = null,

    /// The Amazon EBS volume type. If you do not specify a type, the default is
    /// `gp3`.
    volume_type: EbsVolumeType = .gp3,

    pub const json_field_names = .{
        .ebs_card_index = "ebsCardIndex",
        .encrypted = "encrypted",
        .iops = "iops",
        .kms_key_id = "kmsKeyId",
        .snapshot_id = "snapshotId",
        .throughput = "throughput",
        .volume_initialization_rate = "volumeInitializationRate",
        .volume_size = "volumeSize",
        .volume_type = "volumeType",
    };
};
