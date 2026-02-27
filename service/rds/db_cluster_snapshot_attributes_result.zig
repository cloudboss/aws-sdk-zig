const DBClusterSnapshotAttribute = @import("db_cluster_snapshot_attribute.zig").DBClusterSnapshotAttribute;

/// Contains the results of a successful call to the
/// `DescribeDBClusterSnapshotAttributes` API action.
///
/// Manual DB cluster snapshot attributes are used to authorize other Amazon Web
/// Services accounts to copy or restore a manual DB cluster snapshot. For more
/// information, see the `ModifyDBClusterSnapshotAttribute` API action.
pub const DBClusterSnapshotAttributesResult = struct {
    /// The list of attributes and values for the manual DB cluster snapshot.
    db_cluster_snapshot_attributes: ?[]const DBClusterSnapshotAttribute,

    /// The identifier of the manual DB cluster snapshot that the attributes apply
    /// to.
    db_cluster_snapshot_identifier: ?[]const u8,
};
