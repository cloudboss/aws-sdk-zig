const TieringOperationStatus = @import("tiering_operation_status.zig").TieringOperationStatus;
const SnapshotState = @import("snapshot_state.zig").SnapshotState;
const StorageTier = @import("storage_tier.zig").StorageTier;
const Tag = @import("tag.zig").Tag;

/// Provides information about a snapshot's storage tier.
pub const SnapshotTierStatus = struct {
    /// The date and time when the last archive process was completed.
    archival_complete_time: ?i64,

    /// The status of the last archive or restore process.
    last_tiering_operation_status: ?TieringOperationStatus,

    /// A message describing the status of the last archive or restore process.
    last_tiering_operation_status_detail: ?[]const u8,

    /// The progress of the last archive or restore process, as a percentage.
    last_tiering_progress: ?i32,

    /// The date and time when the last archive or restore process was started.
    last_tiering_start_time: ?i64,

    /// The ID of the Amazon Web Services account that owns the snapshot.
    owner_id: ?[]const u8,

    /// Only for archived snapshots that are temporarily restored. Indicates the
    /// date and
    /// time when a temporarily restored snapshot will be automatically re-archived.
    restore_expiry_time: ?i64,

    /// The ID of the snapshot.
    snapshot_id: ?[]const u8,

    /// The state of the snapshot.
    status: ?SnapshotState,

    /// The storage tier in which the snapshot is stored. `standard` indicates
    /// that the snapshot is stored in the standard snapshot storage tier and that
    /// it is ready
    /// for use. `archive` indicates that the snapshot is currently archived and
    /// that
    /// it must be restored before it can be used.
    storage_tier: ?StorageTier,

    /// The tags that are assigned to the snapshot.
    tags: ?[]const Tag,

    /// The ID of the volume from which the snapshot was created.
    volume_id: ?[]const u8,
};
