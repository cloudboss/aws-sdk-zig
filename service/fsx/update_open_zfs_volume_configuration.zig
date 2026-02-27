const OpenZFSDataCompressionType = @import("open_zfs_data_compression_type.zig").OpenZFSDataCompressionType;
const OpenZFSNfsExport = @import("open_zfs_nfs_export.zig").OpenZFSNfsExport;
const OpenZFSUserOrGroupQuota = @import("open_zfs_user_or_group_quota.zig").OpenZFSUserOrGroupQuota;

/// Used to specify changes to the OpenZFS configuration for the volume
/// that you are updating.
pub const UpdateOpenZFSVolumeConfiguration = struct {
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

    /// The configuration object for mounting a Network File System (NFS) file
    /// system.
    nfs_exports: ?[]const OpenZFSNfsExport,

    /// A Boolean value indicating whether the volume is read-only.
    read_only: ?bool,

    /// Specifies the record size of an OpenZFS volume, in kibibytes (KiB). Valid
    /// values are 4, 8,
    /// 16, 32, 64, 128, 256, 512, or 1024 KiB. The default is 128 KiB.
    /// Most workloads should use the default record size. Database workflows can
    /// benefit from a smaller
    /// record size, while streaming workflows can benefit from a larger record
    /// size. For additional guidance on when
    /// to set a custom record size, see [
    /// Tips for maximizing
    /// performance](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/performance.html#performance-tips-zfs) in the
    /// *Amazon FSx for OpenZFS User Guide*.
    record_size_ki_b: ?i32,

    /// The maximum amount of storage in gibibytes (GiB) that the volume can use
    /// from its
    /// parent. You can specify a quota larger than the storage on the parent
    /// volume. You
    /// can specify a value of `-1` to unset a volume's storage capacity quota.
    storage_capacity_quota_gi_b: ?i32,

    /// The amount of storage in gibibytes (GiB) to reserve from the parent volume.
    /// You can't reserve more storage than the parent volume has reserved. You can
    /// specify
    /// a value of `-1` to unset a volume's storage capacity reservation.
    storage_capacity_reservation_gi_b: ?i32,

    /// An object specifying how much storage users or groups can use on the volume.
    user_and_group_quotas: ?[]const OpenZFSUserOrGroupQuota,

    pub const json_field_names = .{
        .data_compression_type = "DataCompressionType",
        .nfs_exports = "NfsExports",
        .read_only = "ReadOnly",
        .record_size_ki_b = "RecordSizeKiB",
        .storage_capacity_quota_gi_b = "StorageCapacityQuotaGiB",
        .storage_capacity_reservation_gi_b = "StorageCapacityReservationGiB",
        .user_and_group_quotas = "UserAndGroupQuotas",
    };
};
