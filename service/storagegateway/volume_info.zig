/// Describes a storage volume object.
pub const VolumeInfo = struct {
    gateway_arn: ?[]const u8,

    /// The unique identifier assigned to your gateway during activation. This ID
    /// becomes part
    /// of the gateway Amazon Resource Name (ARN), which you use as input for other
    /// operations.
    ///
    /// Valid Values: 50 to 500 lowercase letters, numbers, periods (.), and hyphens
    /// (-).
    gateway_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the storage volume. For example, the
    /// following is a
    /// valid ARN:
    ///
    /// `arn:aws:storagegateway:us-east-2:111122223333:gateway/sgw-12A3456B/volume/vol-1122AABB`
    ///
    /// Valid Values: 50 to 500 lowercase letters, numbers, periods (.), and hyphens
    /// (-).
    volume_arn: ?[]const u8,

    /// One of the VolumeStatus values that indicates the state of the storage
    /// volume.
    volume_attachment_status: ?[]const u8,

    /// The unique identifier assigned to the volume. This ID becomes part of the
    /// volume Amazon
    /// Resource Name (ARN), which you use as input for other operations.
    ///
    /// Valid Values: 50 to 500 lowercase letters, numbers, periods (.), and hyphens
    /// (-).
    volume_id: ?[]const u8,

    /// The size of the volume in bytes.
    ///
    /// Valid Values: 50 to 500 lowercase letters, numbers, periods (.), and hyphens
    /// (-).
    volume_size_in_bytes: i64 = 0,

    /// One of the VolumeType enumeration values describing the type of the volume.
    volume_type: ?[]const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
        .gateway_id = "GatewayId",
        .volume_arn = "VolumeARN",
        .volume_attachment_status = "VolumeAttachmentStatus",
        .volume_id = "VolumeId",
        .volume_size_in_bytes = "VolumeSizeInBytes",
        .volume_type = "VolumeType",
    };
};
