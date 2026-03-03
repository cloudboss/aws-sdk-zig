const VolumeiSCSIAttributes = @import("volumei_scsi_attributes.zig").VolumeiSCSIAttributes;

/// Describes an iSCSI cached volume.
pub const CachediSCSIVolume = struct {
    /// The date the volume was created. Volumes created prior to March 28, 2017
    /// don’t have this
    /// timestamp.
    created_date: ?i64 = null,

    kms_key: ?[]const u8 = null,

    /// If the cached volume was created from a snapshot, this field contains the
    /// snapshot ID
    /// used, e.g., snap-78e22663. Otherwise, this field is not included.
    source_snapshot_id: ?[]const u8 = null,

    /// The name of the iSCSI target used by an initiator to connect to a volume and
    /// used as a
    /// suffix for the target ARN. For example, specifying `TargetName` as
    /// *myvolume* results in the target ARN of
    /// `arn:aws:storagegateway:us-east-2:111122223333:gateway/sgw-12A3456B/target/iqn.1997-05.com.amazon:myvolume`.
    /// The target name must be unique across all volumes on a gateway.
    ///
    /// If you don't specify a value, Storage Gateway uses the value that was
    /// previously
    /// used for this volume as the new target name.
    target_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the storage volume.
    volume_arn: ?[]const u8 = null,

    /// A value that indicates whether a storage volume is attached to or detached
    /// from a
    /// gateway. For more information, see [Moving
    /// your volumes to a different
    /// gateway](https://docs.aws.amazon.com/storagegateway/latest/userguide/managing-volumes.html#attach-detach-volume).
    volume_attachment_status: ?[]const u8 = null,

    /// The unique identifier of the volume, e.g., vol-AE4B946D.
    volume_id: ?[]const u8 = null,

    /// An VolumeiSCSIAttributes object that represents a collection of iSCSI
    /// attributes for one stored volume.
    volumei_scsi_attributes: ?VolumeiSCSIAttributes = null,

    /// Represents the percentage complete if the volume is restoring or
    /// bootstrapping that
    /// represents the percent of data transferred. This field does not appear in
    /// the response if
    /// the cached volume is not restoring or bootstrapping.
    volume_progress: ?f64 = null,

    /// The size, in bytes, of the volume capacity.
    volume_size_in_bytes: i64 = 0,

    /// One of the VolumeStatus values that indicates the state of the storage
    /// volume.
    volume_status: ?[]const u8 = null,

    /// One of the VolumeType enumeration values that describes the type of the
    /// volume.
    volume_type: ?[]const u8 = null,

    /// The size of the data stored on the volume in bytes. This value is calculated
    /// based on
    /// the number of blocks that are touched, instead of the actual amount of data
    /// written. This
    /// value can be useful for sequential write patterns but less accurate for
    /// random write
    /// patterns. `VolumeUsedInBytes` is different from the compressed size of the
    /// volume, which is the value that is used to calculate your bill.
    ///
    /// This value is not available for volumes created prior to May 13, 2015, until
    /// you
    /// store data on the volume.
    ///
    /// If you use a delete tool that overwrites the data on your volume with random
    /// data,
    /// your usage will not be reduced. This is because the random data is not
    /// compressible. If
    /// you want to reduce the amount of billed storage on your volume, we recommend
    /// overwriting
    /// your files with zeros to compress the data to a negligible amount of actual
    /// storage.
    volume_used_in_bytes: ?i64 = null,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .kms_key = "KMSKey",
        .source_snapshot_id = "SourceSnapshotId",
        .target_name = "TargetName",
        .volume_arn = "VolumeARN",
        .volume_attachment_status = "VolumeAttachmentStatus",
        .volume_id = "VolumeId",
        .volumei_scsi_attributes = "VolumeiSCSIAttributes",
        .volume_progress = "VolumeProgress",
        .volume_size_in_bytes = "VolumeSizeInBytes",
        .volume_status = "VolumeStatus",
        .volume_type = "VolumeType",
        .volume_used_in_bytes = "VolumeUsedInBytes",
    };
};
