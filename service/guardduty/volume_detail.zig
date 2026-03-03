/// Contains EBS volume details.
pub const VolumeDetail = struct {
    /// The device name for the EBS volume.
    device_name: ?[]const u8 = null,

    /// EBS volume encryption type.
    encryption_type: ?[]const u8 = null,

    /// KMS key ARN used to encrypt the EBS volume.
    kms_key_arn: ?[]const u8 = null,

    /// Snapshot ARN of the EBS volume.
    snapshot_arn: ?[]const u8 = null,

    /// EBS volume ARN information.
    volume_arn: ?[]const u8 = null,

    /// EBS volume size in GB.
    volume_size_in_gb: ?i32 = null,

    /// The EBS volume type.
    volume_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_name = "DeviceName",
        .encryption_type = "EncryptionType",
        .kms_key_arn = "KmsKeyArn",
        .snapshot_arn = "SnapshotArn",
        .volume_arn = "VolumeArn",
        .volume_size_in_gb = "VolumeSizeInGB",
        .volume_type = "VolumeType",
    };
};
