/// Contains the name and values of a manual DB snapshot attribute
///
/// Manual DB snapshot attributes are used to authorize other Amazon Web
/// Services accounts to restore a manual DB snapshot. For more information, see
/// the `ModifyDBSnapshotAttribute` API.
pub const DBSnapshotAttribute = struct {
    /// The name of the manual DB snapshot attribute.
    ///
    /// The attribute named `restore` refers to the list of Amazon Web Services
    /// accounts that have permission to copy or restore the manual DB cluster
    /// snapshot. For more information, see the `ModifyDBSnapshotAttribute` API
    /// action.
    attribute_name: ?[]const u8 = null,

    /// The value or values for the manual DB snapshot attribute.
    ///
    /// If the `AttributeName` field is set to `restore`, then this element returns
    /// a list of IDs of the Amazon Web Services accounts that are authorized to
    /// copy or restore the manual DB snapshot. If a value of `all` is in the list,
    /// then the manual DB snapshot is public and available for any Amazon Web
    /// Services account to copy or restore.
    attribute_values: ?[]const []const u8 = null,
};
