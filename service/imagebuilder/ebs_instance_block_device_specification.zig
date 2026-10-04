const EbsVolumeType = @import("ebs_volume_type.zig").EbsVolumeType;

/// Amazon EBS-specific block device mapping specifications.
pub const EbsInstanceBlockDeviceSpecification = struct {
    /// Specifies whether to delete the associated device on termination.
    delete_on_termination: ?bool = null,

    /// Specifies whether to encrypt the device.
    encrypted: ?bool = null,

    /// The IOPS value for the device. Required only when volumeType is io1 or io2.
    iops: ?i32 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the KMS key to use
    /// when encrypting the device.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    /// The snapshot that defines the device contents.
    snapshot_id: ?[]const u8 = null,

    /// **For GP3 volumes only** – The throughput in MiB/s
    /// that the volume supports.
    throughput: ?i32 = null,

    /// Overrides the volume size for the device.
    volume_size: ?i32 = null,

    /// Overrides the volume type for the device.
    volume_type: ?EbsVolumeType = null,

    pub const json_field_names = .{
        .delete_on_termination = "deleteOnTermination",
        .encrypted = "encrypted",
        .iops = "iops",
        .kms_key_id = "kmsKeyId",
        .snapshot_id = "snapshotId",
        .throughput = "throughput",
        .volume_size = "volumeSize",
        .volume_type = "volumeType",
    };
};
