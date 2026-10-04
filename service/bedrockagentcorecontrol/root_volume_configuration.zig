const EbsVolumeType = @import("ebs_volume_type.zig").EbsVolumeType;

/// The configuration for the root volume of a capacity provider instance.
/// Specify the amount of free space to guarantee on the root volume. The device
/// name and delete-on-termination settings are fixed and cannot be changed.
pub const RootVolumeConfiguration = struct {
    /// Specifies whether to encrypt the volume. Encrypted volumes can be attached
    /// only to instances that support Amazon EBS encryption. If you create a volume
    /// from a snapshot, you cannot specify an encryption value.
    encrypted: ?bool = null,

    /// The free space guaranteed on the root volume, in GiB. AgentCore adds the
    /// operating system overhead on top of this value. The default is 8 GiB.
    free_space_gi_b: ?i32 = null,

    /// The number of IOPS to provision. For `gp3`, `io1`, and `io2` volumes, this
    /// is the number of IOPS provisioned for the volume. For `gp2` volumes, this
    /// sets the baseline IOPS performance. It also controls the rate at which the
    /// volume accumulates I/O credits for bursting. Supported values: `gp3`,
    /// 3,000–80,000; `io1`, 100–64,000; `io2`, 100–256,000.
    iops: ?i32 = null,

    /// The identifier (key ID, key alias, key ARN, or alias ARN) of the customer
    /// managed KMS key to use for Amazon EBS encryption.
    kms_key_id: ?[]const u8 = null,

    /// The throughput to provision, in MiB/s. Valid only for `gp3` volumes. Valid
    /// range: 125–2,000 MiB/s.
    throughput: ?i32 = null,

    /// The Amazon EBS volume type. If you do not specify a type, the default is
    /// `gp3`.
    volume_type: EbsVolumeType = .gp3,

    pub const json_field_names = .{
        .encrypted = "encrypted",
        .free_space_gi_b = "freeSpaceGiB",
        .iops = "iops",
        .kms_key_id = "kmsKeyId",
        .throughput = "throughput",
        .volume_type = "volumeType",
    };
};
