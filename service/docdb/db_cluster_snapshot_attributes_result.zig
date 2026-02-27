const DBClusterSnapshotAttribute = @import("db_cluster_snapshot_attribute.zig").DBClusterSnapshotAttribute;

/// Detailed information about the attributes that are associated with a cluster
/// snapshot.
pub const DBClusterSnapshotAttributesResult = struct {
    /// The list of attributes and values for the cluster snapshot.
    db_cluster_snapshot_attributes: ?[]const DBClusterSnapshotAttribute,

    /// The identifier of the cluster snapshot that the attributes apply to.
    db_cluster_snapshot_identifier: ?[]const u8,
};
