const EbsVolumeType = @import("ebs_volume_type.zig").EbsVolumeType;

/// Amazon EBS-specific block device mapping specifications.
pub const EbsInstanceBlockDeviceSpecification = struct {
    /// Use to configure delete on termination of the associated device.
    delete_on_termination: ?bool,

    /// Use to configure device encryption.
    encrypted: ?bool,

    /// Use to configure device IOPS.
    iops: ?i32,

    /// The Amazon Resource Name (ARN) that uniquely identifies the KMS key to use
    /// when encrypting the device.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// The snapshot that defines the device contents.
    snapshot_id: ?[]const u8,

    /// **For GP3 volumes only** – The throughput in MiB/s
    /// that the volume supports.
    throughput: ?i32,

    /// Use to override the device's volume size.
    volume_size: ?i32,

    /// Use to override the device's volume type.
    volume_type: ?EbsVolumeType,

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
