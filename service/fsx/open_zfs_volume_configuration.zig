const OpenZFSCopyStrategy = @import("open_zfs_copy_strategy.zig").OpenZFSCopyStrategy;
const OpenZFSDataCompressionType = @import("open_zfs_data_compression_type.zig").OpenZFSDataCompressionType;
const OpenZFSNfsExport = @import("open_zfs_nfs_export.zig").OpenZFSNfsExport;
const OpenZFSOriginSnapshotConfiguration = @import("open_zfs_origin_snapshot_configuration.zig").OpenZFSOriginSnapshotConfiguration;
const OpenZFSUserOrGroupQuota = @import("open_zfs_user_or_group_quota.zig").OpenZFSUserOrGroupQuota;

/// The configuration of an Amazon FSx for OpenZFS volume.
pub const OpenZFSVolumeConfiguration = struct {
    /// Specifies the strategy used when copying data from the snapshot to the new
    /// volume.
    ///
    /// * `CLONE` - The new volume references the data in the origin
    /// snapshot. Cloning a snapshot is faster than copying data from the snapshot
    /// to a
    /// new volume and doesn't consume disk throughput. However, the origin snapshot
    /// can't be deleted if there is a volume using its copied data.
    ///
    /// * `FULL_COPY` - Copies all data from the snapshot to the new
    /// volume.
    ///
    /// Specify this option to create the volume from a snapshot on another FSx for
    /// OpenZFS file system.
    ///
    /// The `INCREMENTAL_COPY` option is only for updating an existing volume
    /// by using a snapshot from another FSx for OpenZFS file system. For more
    /// information, see
    /// [CopySnapshotAndUpdateVolume](https://docs.aws.amazon.com/fsx/latest/APIReference/API_CopySnapshotAndUpdateVolume.html).
    copy_strategy: ?OpenZFSCopyStrategy = null,

    /// A Boolean value indicating whether tags for the volume should be copied to
    /// snapshots.
    /// This value defaults to `false`. If it's set to `true`, all tags
    /// for the volume are copied to snapshots where the user doesn't specify tags.
    /// If this
    /// value is `true` and you specify one or more tags, only the specified tags
    /// are
    /// copied to snapshots. If you specify one or more tags when creating the
    /// snapshot, no tags
    /// are copied from the volume, regardless of this value.
    copy_tags_to_snapshots: ?bool = null,

    /// Specifies the method used to compress the data on the volume. The
    /// compression
    /// type is `NONE` by default.
    ///
    /// * `NONE` - Doesn't compress the data on the volume.
    /// `NONE` is the default.
    ///
    /// * `ZSTD` - Compresses the data in the volume using the Zstandard
    /// (ZSTD) compression algorithm. Compared to LZ4, Z-Standard provides a better
    /// compression ratio to minimize on-disk storage utilization.
    ///
    /// * `LZ4` - Compresses the data in the volume using the LZ4
    /// compression algorithm. Compared to Z-Standard, LZ4 is less compute-intensive
    /// and delivers higher write throughput speeds.
    data_compression_type: ?OpenZFSDataCompressionType = null,

    /// A Boolean value indicating whether dependent clone volumes
    /// created from intermediate snapshots should be deleted when
    /// a volume is restored from snapshot.
    delete_cloned_volumes: ?bool = null,

    /// A Boolean value indicating whether snapshot data that differs between the
    /// current state and the specified snapshot should be overwritten when a volume
    /// is restored from a snapshot.
    delete_intermediate_data: ?bool = null,

    /// A Boolean value indicating whether snapshots between the
    /// current state and the specified snapshot should be deleted
    /// when a volume is restored from snapshot.
    delete_intermediate_snaphots: ?bool = null,

    /// The ID of the snapshot that's being copied or was most recently copied to
    /// the
    /// destination volume.
    destination_snapshot: ?[]const u8 = null,

    /// The configuration object for mounting a Network File System (NFS)
    /// file system.
    nfs_exports: ?[]const OpenZFSNfsExport = null,

    /// The configuration object that specifies the snapshot to use as the origin of
    /// the data
    /// for the volume.
    origin_snapshot: ?OpenZFSOriginSnapshotConfiguration = null,

    /// The ID of the parent volume.
    parent_volume_id: ?[]const u8 = null,

    /// A Boolean value indicating whether the volume is read-only.
    read_only: ?bool = null,

    /// The record size of an OpenZFS volume, in kibibytes (KiB). Valid values are
    /// 4, 8,
    /// 16, 32, 64, 128, 256, 512, or 1024 KiB. The default is 128 KiB.
    /// Most workloads should use the default record size. For guidance on when
    /// to set a custom record size, see the
    /// *Amazon FSx for OpenZFS User Guide*.
    record_size_ki_b: ?i32 = null,

    /// Specifies the ID of the snapshot to which the volume was restored.
    restore_to_snapshot: ?[]const u8 = null,

    source_snapshot_arn: ?[]const u8 = null,

    /// The maximum amount of storage in gibibytes (GiB) that the volume can use
    /// from its
    /// parent. You can specify a quota larger than the storage on the parent
    /// volume.
    storage_capacity_quota_gi_b: ?i32 = null,

    /// The amount of storage in gibibytes (GiB) to reserve from the parent volume.
    /// You can't
    /// reserve more storage than the parent volume has reserved.
    storage_capacity_reservation_gi_b: ?i32 = null,

    /// An object specifying how much storage users or groups can use on the volume.
    user_and_group_quotas: ?[]const OpenZFSUserOrGroupQuota = null,

    /// The path to the volume from the root volume. For example,
    /// `fsx/parentVolume/volume1`.
    volume_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .copy_strategy = "CopyStrategy",
        .copy_tags_to_snapshots = "CopyTagsToSnapshots",
        .data_compression_type = "DataCompressionType",
        .delete_cloned_volumes = "DeleteClonedVolumes",
        .delete_intermediate_data = "DeleteIntermediateData",
        .delete_intermediate_snaphots = "DeleteIntermediateSnaphots",
        .destination_snapshot = "DestinationSnapshot",
        .nfs_exports = "NfsExports",
        .origin_snapshot = "OriginSnapshot",
        .parent_volume_id = "ParentVolumeId",
        .read_only = "ReadOnly",
        .record_size_ki_b = "RecordSizeKiB",
        .restore_to_snapshot = "RestoreToSnapshot",
        .source_snapshot_arn = "SourceSnapshotARN",
        .storage_capacity_quota_gi_b = "StorageCapacityQuotaGiB",
        .storage_capacity_reservation_gi_b = "StorageCapacityReservationGiB",
        .user_and_group_quotas = "UserAndGroupQuotas",
        .volume_path = "VolumePath",
    };
};
