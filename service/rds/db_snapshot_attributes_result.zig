const DBSnapshotAttribute = @import("db_snapshot_attribute.zig").DBSnapshotAttribute;

/// Contains the results of a successful call to the
/// `DescribeDBSnapshotAttributes` API action.
///
/// Manual DB snapshot attributes are used to authorize other Amazon Web
/// Services accounts to copy or restore a manual DB snapshot. For more
/// information, see the `ModifyDBSnapshotAttribute` API action.
pub const DBSnapshotAttributesResult = struct {
    /// The list of attributes and values for the manual DB snapshot.
    db_snapshot_attributes: ?[]const DBSnapshotAttribute = null,

    /// The identifier of the manual DB snapshot that the attributes apply to.
    db_snapshot_identifier: ?[]const u8 = null,
};
