/// Contains the name and values of a manual DB cluster snapshot attribute.
///
/// Manual DB cluster snapshot attributes are used to authorize other Amazon
/// accounts to restore
/// a manual DB cluster snapshot. For more information, see the
/// ModifyDBClusterSnapshotAttribute API action.
pub const DBClusterSnapshotAttribute = struct {
    /// The name of the manual DB cluster snapshot attribute.
    ///
    /// The attribute named `restore` refers to the list of Amazon accounts that
    /// have
    /// permission to copy or restore the manual DB cluster snapshot. For more
    /// information, see the
    /// ModifyDBClusterSnapshotAttribute API action.
    attribute_name: ?[]const u8 = null,

    /// The value(s) for the manual DB cluster snapshot attribute.
    ///
    /// If the `AttributeName` field is set to `restore`, then this element
    /// returns a list of IDs of the Amazon accounts that are authorized to copy or
    /// restore the manual DB
    /// cluster snapshot. If a value of `all` is in the list, then the manual DB
    /// cluster
    /// snapshot is public and available for any Amazon account to copy or restore.
    attribute_values: ?[]const []const u8 = null,
};
