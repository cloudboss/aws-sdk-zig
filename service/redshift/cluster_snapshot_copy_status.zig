/// Returns the destination region and retention period that are configured for
/// cross-region snapshot copy.
pub const ClusterSnapshotCopyStatus = struct {
    /// The destination region that snapshots are automatically copied to when
    /// cross-region
    /// snapshot copy is enabled.
    destination_region: ?[]const u8,

    /// The number of days that automated snapshots are retained in the destination
    /// region
    /// after they are copied from a source region. If the value is -1, the manual
    /// snapshot is
    /// retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    manual_snapshot_retention_period: ?i32,

    /// The number of days that automated snapshots are retained in the destination
    /// region
    /// after they are copied from a source region.
    retention_period: ?i64,

    /// The name of the snapshot copy grant.
    snapshot_copy_grant_name: ?[]const u8,
};
