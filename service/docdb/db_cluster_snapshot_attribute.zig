/// Contains the name and values of a manual cluster snapshot attribute.
///
/// Manual cluster snapshot attributes are used to authorize other Amazon Web
/// Services accounts to restore a manual cluster snapshot.
pub const DBClusterSnapshotAttribute = struct {
    /// The name of the manual cluster snapshot attribute.
    ///
    /// The attribute named `restore` refers to the list of Amazon Web Services
    /// accounts that have permission to copy or restore the manual cluster
    /// snapshot.
    attribute_name: ?[]const u8,

    /// The values for the manual cluster snapshot attribute.
    ///
    /// If the `AttributeName` field is set to `restore`, then this element returns
    /// a list of IDs of the Amazon Web Services accounts that are authorized to
    /// copy or restore the manual cluster snapshot. If a value of `all` is in the
    /// list, then the manual cluster snapshot is public and available for any
    /// Amazon Web Services account to copy or restore.
    attribute_values: ?[]const []const u8,
};
