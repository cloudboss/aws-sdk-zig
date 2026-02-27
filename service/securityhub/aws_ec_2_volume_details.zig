const AwsEc2VolumeAttachment = @import("aws_ec_2_volume_attachment.zig").AwsEc2VolumeAttachment;

/// Details about an EC2 volume.
pub const AwsEc2VolumeDetails = struct {
    /// The volume attachments.
    attachments: ?[]const AwsEc2VolumeAttachment,

    /// Indicates when the volume was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    create_time: ?[]const u8,

    /// The device name for the volume that is attached to the instance.
    device_name: ?[]const u8,

    /// Specifies whether the volume is encrypted.
    encrypted: ?bool,

    /// The ARN of the KMS key that was
    /// used to protect the volume encryption key for the volume.
    kms_key_id: ?[]const u8,

    /// The size of the volume, in GiBs.
    size: ?i32,

    /// The snapshot from which the volume was created.
    snapshot_id: ?[]const u8,

    /// The volume state. Valid values are as follows:
    ///
    /// * `available`
    ///
    /// * `creating`
    ///
    /// * `deleted`
    ///
    /// * `deleting`
    ///
    /// * `error`
    ///
    /// * `in-use`
    status: ?[]const u8,

    /// The ID of the volume.
    volume_id: ?[]const u8,

    /// Indicates whether the volume was scanned or skipped.
    volume_scan_status: ?[]const u8,

    /// The volume type.
    volume_type: ?[]const u8,

    pub const json_field_names = .{
        .attachments = "Attachments",
        .create_time = "CreateTime",
        .device_name = "DeviceName",
        .encrypted = "Encrypted",
        .kms_key_id = "KmsKeyId",
        .size = "Size",
        .snapshot_id = "SnapshotId",
        .status = "Status",
        .volume_id = "VolumeId",
        .volume_scan_status = "VolumeScanStatus",
        .volume_type = "VolumeType",
    };
};
