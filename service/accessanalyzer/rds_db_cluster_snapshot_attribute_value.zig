/// The values for a manual Amazon RDS DB cluster snapshot attribute.
pub const RdsDbClusterSnapshotAttributeValue = union(enum) {
    /// The Amazon Web Services account IDs that have access to the manual Amazon
    /// RDS DB cluster snapshot. If the value `all` is specified, then the Amazon
    /// RDS DB cluster snapshot is public and can be copied or restored by all
    /// Amazon Web Services accounts.
    ///
    /// * If the configuration is for an existing Amazon RDS DB cluster snapshot and
    ///   you do not specify the `accountIds` in
    ///   `RdsDbClusterSnapshotAttributeValue`, then the access preview uses the
    ///   existing shared `accountIds` for the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   specify the `accountIds` in `RdsDbClusterSnapshotAttributeValue`, then the
    ///   access preview considers the snapshot without any attributes.
    /// * To propose deletion of existing shared `accountIds`, you can specify an
    ///   empty list for `accountIds` in the `RdsDbClusterSnapshotAttributeValue`.
    account_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
    };
};
