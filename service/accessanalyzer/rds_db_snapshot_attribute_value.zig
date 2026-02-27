/// The name and values of a manual Amazon RDS DB snapshot attribute. Manual DB
/// snapshot attributes are used to authorize other Amazon Web Services accounts
/// to restore a manual DB snapshot.
pub const RdsDbSnapshotAttributeValue = union(enum) {
    /// The Amazon Web Services account IDs that have access to the manual Amazon
    /// RDS DB snapshot. If the value `all` is specified, then the Amazon RDS DB
    /// snapshot is public and can be copied or restored by all Amazon Web Services
    /// accounts.
    ///
    /// * If the configuration is for an existing Amazon RDS DB snapshot and you do
    ///   not specify the `accountIds` in `RdsDbSnapshotAttributeValue`, then the
    ///   access preview uses the existing shared `accountIds` for the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   specify the `accountIds` in `RdsDbSnapshotAttributeValue`, then the access
    ///   preview considers the snapshot without any attributes.
    /// * To propose deletion of an existing shared `accountIds`, you can specify an
    ///   empty list for `accountIds` in the `RdsDbSnapshotAttributeValue`.
    account_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};
