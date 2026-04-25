/// The status of the DB parameter group.
///
/// This data type is used as a response element in the following actions:
///
/// * CreateDBInstance
///
/// * DeleteDBInstance
///
/// * ModifyDBInstance
///
/// * RebootDBInstance
pub const DBParameterGroupStatus = struct {
    /// The name of the DB parameter group.
    db_parameter_group_name: ?[]const u8 = null,

    /// The status of parameter updates.
    parameter_apply_status: ?[]const u8 = null,
};
