const OpenZFSCopyStrategy = @import("open_zfs_copy_strategy.zig").OpenZFSCopyStrategy;

/// The snapshot configuration to use when creating an Amazon FSx for OpenZFS
/// volume from a snapshot.
pub const CreateOpenZFSOriginSnapshotConfiguration = struct {
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
    copy_strategy: OpenZFSCopyStrategy,

    snapshot_arn: []const u8,

    pub const json_field_names = .{
        .copy_strategy = "CopyStrategy",
        .snapshot_arn = "SnapshotARN",
    };
};
