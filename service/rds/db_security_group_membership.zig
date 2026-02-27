/// This data type is used as a response element in the following actions:
///
/// * `ModifyDBInstance`
/// * `RebootDBInstance`
/// * `RestoreDBInstanceFromDBSnapshot`
/// * `RestoreDBInstanceToPointInTime`
pub const DBSecurityGroupMembership = struct {
    /// The name of the DB security group.
    db_security_group_name: ?[]const u8,

    /// The status of the DB security group.
    status: ?[]const u8,
};
