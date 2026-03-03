const OpenZFSDataCompressionType = @import("open_zfs_data_compression_type.zig").OpenZFSDataCompressionType;
const OpenZFSNfsExport = @import("open_zfs_nfs_export.zig").OpenZFSNfsExport;
const CreateOpenZFSOriginSnapshotConfiguration = @import("create_open_zfs_origin_snapshot_configuration.zig").CreateOpenZFSOriginSnapshotConfiguration;
const OpenZFSUserOrGroupQuota = @import("open_zfs_user_or_group_quota.zig").OpenZFSUserOrGroupQuota;

/// Specifies the configuration of the Amazon FSx for OpenZFS volume that you
/// are creating.
pub const CreateOpenZFSVolumeConfiguration = struct {
    /// A Boolean value indicating whether tags for the volume should be copied to
    /// snapshots.
    /// This value defaults to `false`. If this value is set to `true`, and you do
    /// not specify any tags, all tags for the original volume are copied over to
    /// snapshots.
    /// If this value is set to `true`, and you do specify one or more tags, only
    /// the specified tags for the original volume are copied over to snapshots. If
    /// you specify one or more tags when creating a new snapshot, no tags are
    /// copied over from the original volume, regardless of this value.
    copy_tags_to_snapshots: ?bool = null,

    /// Specifies the method used to compress the data on the volume. The
    /// compression
    /// type is `NONE` by default.
    ///
    /// * `NONE` - Doesn't compress the data on the volume.
    /// `NONE` is the default.
    ///
    /// * `ZSTD` - Compresses the data in the volume using the Zstandard
    /// (ZSTD) compression algorithm. ZSTD compression provides a higher level of
    /// data compression and higher read throughput performance than LZ4
    /// compression.
    ///
    /// * `LZ4` - Compresses the data in the volume using the LZ4
    /// compression algorithm. LZ4 compression provides a lower level of compression
    /// and higher write throughput performance than ZSTD compression.
    ///
    /// For more information about volume compression types and the performance of
    /// your Amazon FSx for OpenZFS file system,
    /// see [
    /// Tips for maximizing
    /// performance](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance.html#performance-tips-zfs) File system and volume settings in the *Amazon FSx for OpenZFS User Guide*.
    data_compression_type: ?OpenZFSDataCompressionType = null,

    /// The configuration object for mounting a Network File System (NFS) file
    /// system.
    nfs_exports: ?[]const OpenZFSNfsExport = null,

    /// The configuration object that specifies the snapshot to use as the origin of
    /// the data
    /// for the volume.
    origin_snapshot: ?CreateOpenZFSOriginSnapshotConfiguration = null,

    /// The ID of the volume to use as the parent volume of the volume that you are
    /// creating.
    parent_volume_id: []const u8,

    /// A Boolean value indicating whether the volume is read-only.
    read_only: ?bool = null,

    /// Specifies the suggested block size for a volume in a ZFS dataset, in
    /// kibibytes (KiB).
    /// For file systems using the Intelligent-Tiering storage class, valid values
    /// are 128, 256, 512, 1024, 2048, or 4096 KiB, with a default of 1024 KiB.
    /// For all other file systems, valid values are 4, 8, 16, 32, 64, 128, 256,
    /// 512, or 1024 KiB, with a default of 128 KiB.
    /// We recommend using the default setting for the majority of use cases.
    /// Generally, workloads that write in fixed small or large record sizes may
    /// benefit from setting a custom record size, like database workloads (small
    /// record size) or media streaming workloads (large record size).
    /// For additional guidance on when to set a custom record size, see
    /// [
    /// ZFS Record
    /// size](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance.html#record-size-performance) in the *Amazon FSx for OpenZFS User Guide*.
    record_size_ki_b: ?i32 = null,

    /// Sets the maximum storage size in gibibytes (GiB) for the volume. You can
    /// specify
    /// a quota that is larger than the storage on the parent volume. A volume quota
    /// limits
    /// the amount of storage that the volume can consume to the configured amount,
    /// but does not
    /// guarantee the space will be available on the parent volume. To guarantee
    /// quota space, you must also set
    /// `StorageCapacityReservationGiB`. To *not* specify a storage capacity quota,
    /// set this to `-1`.
    ///
    /// For more information, see
    /// [Volume
    /// properties](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/managing-volumes.html#volume-properties)
    /// in the *Amazon FSx for OpenZFS User Guide*.
    storage_capacity_quota_gi_b: ?i32 = null,

    /// Specifies the amount of storage in gibibytes (GiB) to reserve from the
    /// parent volume. Setting
    /// `StorageCapacityReservationGiB` guarantees that the specified amount of
    /// storage space
    /// on the parent volume will always be available for the volume.
    /// You can't reserve more storage than the parent volume has. To *not* specify
    /// a storage capacity
    /// reservation, set this to `0` or `-1`. For more information, see
    /// [Volume
    /// properties](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/managing-volumes.html#volume-properties)
    /// in the *Amazon FSx for OpenZFS User Guide*.
    storage_capacity_reservation_gi_b: ?i32 = null,

    /// Configures how much storage users and groups can use on the volume.
    user_and_group_quotas: ?[]const OpenZFSUserOrGroupQuota = null,

    pub const json_field_names = .{
        .copy_tags_to_snapshots = "CopyTagsToSnapshots",
        .data_compression_type = "DataCompressionType",
        .nfs_exports = "NfsExports",
        .origin_snapshot = "OriginSnapshot",
        .parent_volume_id = "ParentVolumeId",
        .read_only = "ReadOnly",
        .record_size_ki_b = "RecordSizeKiB",
        .storage_capacity_quota_gi_b = "StorageCapacityQuotaGiB",
        .storage_capacity_reservation_gi_b = "StorageCapacityReservationGiB",
        .user_and_group_quotas = "UserAndGroupQuotas",
    };
};
