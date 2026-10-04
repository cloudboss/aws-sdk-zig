const EbsVolumeType = @import("ebs_volume_type.zig").EbsVolumeType;

/// The configuration for an Amazon EBS-backed persistent volume. The service
/// creates persistent volumes when a session first launches, and the volumes
/// survive instance termination. The volumes persist until you delete the
/// session.
pub const EbsVolumeConfiguration = struct {
    /// Specifies whether to encrypt the volume. If `true`, the service encrypts the
    /// volume with the KMS key that you specify in `kmsKeyId`, or the default KMS
    /// key for Amazon EBS if you do not specify one. The default is `true`.
    encrypted: ?bool = null,

    /// The number of IOPS to provision. Valid only for `gp3`, `io1`, and `io2`
    /// volumes.
    iops: ?i32 = null,

    /// The identifier of the KMS key to use for encryption.
    kms_key_id: ?[]const u8 = null,

    /// The logical name of the volume. Use this name to reference the volume when
    /// you mount it into an agent runtime.
    name: []const u8,

    /// The size of the volume, in GiB.
    size_gi_b: i32,

    /// An optional Amazon EBS snapshot ID. If provided, the volume is initialized
    /// from this snapshot the first time it is created. On subsequent restarts, the
    /// existing volume is used and the snapshot is ignored.
    snapshot_id: ?[]const u8 = null,

    /// The throughput, in MiB/s. Valid only for `gp3` volumes.
    throughput: ?i32 = null,

    /// The Amazon EBS volume type. If you do not specify a type, the default is
    /// `gp3`.
    volume_type: EbsVolumeType = .gp3,

    pub const json_field_names = .{
        .encrypted = "encrypted",
        .iops = "iops",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .size_gi_b = "sizeGiB",
        .snapshot_id = "snapshotId",
        .throughput = "throughput",
        .volume_type = "volumeType",
    };
};
