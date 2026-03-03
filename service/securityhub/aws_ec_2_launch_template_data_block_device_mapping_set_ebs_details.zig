/// Parameters for a block device for an Amazon Elastic Block Store (Amazon EBS)
/// volume in an Amazon EC2 launch template.
pub const AwsEc2LaunchTemplateDataBlockDeviceMappingSetEbsDetails = struct {
    /// Indicates whether the EBS volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// Indicates whether the EBS volume is encrypted. Encrypted volumes can only be
    /// attached to instances that support Amazon EBS encryption. If you're creating
    /// a
    /// volume from a snapshot, you can't specify an encryption value.
    encrypted: ?bool = null,

    /// The number of I/O operations per second (IOPS).
    iops: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the symmetric Key Management Service (KMS)
    /// customer managed key
    /// used for encryption.
    kms_key_id: ?[]const u8 = null,

    /// The ID of the EBS snapshot.
    snapshot_id: ?[]const u8 = null,

    /// The throughput to provision for a gp3 volume, with a maximum of 1,000 MiB/s.
    throughput: ?i32 = null,

    /// The size of the volume, in GiBs. You must specify either a snapshot ID or a
    /// volume size.
    volume_size: ?i32 = null,

    /// The volume type.
    volume_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .delete_on_termination = "DeleteOnTermination",
        .encrypted = "Encrypted",
        .iops = "Iops",
        .kms_key_id = "KmsKeyId",
        .snapshot_id = "SnapshotId",
        .throughput = "Throughput",
        .volume_size = "VolumeSize",
        .volume_type = "VolumeType",
    };
};
