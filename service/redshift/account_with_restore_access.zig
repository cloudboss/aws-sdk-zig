/// Describes an Amazon Web Services account authorized to restore a snapshot.
pub const AccountWithRestoreAccess = struct {
    /// The identifier of an Amazon Web Services support account authorized to
    /// restore a
    /// snapshot. For Amazon Web Services Support, the identifier is
    /// `amazon-redshift-support`.
    account_alias: ?[]const u8,

    /// The identifier of an Amazon Web Services account authorized to restore a
    /// snapshot.
    account_id: ?[]const u8,
};
