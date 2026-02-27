const OpenZFSDataCompressionType = @import("open_zfs_data_compression_type.zig").OpenZFSDataCompressionType;
const OpenZFSNfsExport = @import("open_zfs_nfs_export.zig").OpenZFSNfsExport;
const OpenZFSUserOrGroupQuota = @import("open_zfs_user_or_group_quota.zig").OpenZFSUserOrGroupQuota;

/// The configuration of an Amazon FSx for OpenZFS root volume.
pub const OpenZFSCreateRootVolumeConfiguration = struct {
    /// A Boolean value indicating whether tags for the volume should be copied to
    /// snapshots
    /// of the volume. This value defaults to `false`. If it's set to `true`,
    /// all tags for the volume are copied to snapshots where the user doesn't
    /// specify tags. If this
    /// value is `true` and you specify one or more tags, only the specified tags
    /// are
    /// copied to snapshots. If you specify one or more tags when creating the
    /// snapshot, no tags
    /// are copied from the volume, regardless of this value.
    copy_tags_to_snapshots: ?bool,

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
    data_compression_type: ?OpenZFSDataCompressionType,

    /// The configuration object for mounting a file system.
    nfs_exports: ?[]const OpenZFSNfsExport,

    /// A Boolean value indicating whether the volume is read-only. Setting this
    /// value to
    /// `true` can be useful after you have completed changes to a volume and no
    /// longer want changes to occur.
    read_only: ?bool,

    /// Specifies the record size of an OpenZFS root volume, in kibibytes (KiB).
    /// Valid values are 4, 8,
    /// 16, 32, 64, 128, 256, 512, or 1024 KiB. The default is 128 KiB. Most
    /// workloads should use the
    /// default record size. Database workflows can benefit from a smaller record
    /// size, while streaming
    /// workflows can benefit from a larger record size. For additional guidance on
    /// setting a custom record
    /// size, see [
    /// Tips for maximizing
    /// performance](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance.html#performance-tips-zfs) in the
    /// *Amazon FSx for OpenZFS User Guide*.
    record_size_ki_b: ?i32,

    /// An object specifying how much storage users or groups can use on the volume.
    user_and_group_quotas: ?[]const OpenZFSUserOrGroupQuota,

    pub const json_field_names = .{
        .copy_tags_to_snapshots = "CopyTagsToSnapshots",
        .data_compression_type = "DataCompressionType",
        .nfs_exports = "NfsExports",
        .read_only = "ReadOnly",
        .record_size_ki_b = "RecordSizeKiB",
        .user_and_group_quotas = "UserAndGroupQuotas",
    };
};
