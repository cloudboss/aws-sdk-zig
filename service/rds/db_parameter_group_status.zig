/// The status of the DB parameter group.
///
/// This data type is used as a response element in the following actions:
///
/// * `CreateDBInstance`
/// * `CreateDBInstanceReadReplica`
/// * `DeleteDBInstance`
/// * `ModifyDBInstance`
/// * `RebootDBInstance`
/// * `RestoreDBInstanceFromDBSnapshot`
pub const DBParameterGroupStatus = struct {
    /// The name of the DB parameter group.
    db_parameter_group_name: ?[]const u8,

    /// The status of parameter updates. Valid values are:
    ///
    /// * `applying`: The parameter group change is being applied to the database.
    /// * `failed-to-apply`: The parameter group is in an invalid state.
    /// * `in-sync`: The parameter group change is synchronized with the database.
    /// * `pending-database-upgrade`: The parameter group change will be applied
    ///   after the DB instance is upgraded.
    /// * `pending-reboot`: The parameter group change will be applied after the DB
    ///   instance reboots.
    parameter_apply_status: ?[]const u8,
};
