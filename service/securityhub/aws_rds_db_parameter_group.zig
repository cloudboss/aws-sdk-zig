/// Provides information about a parameter group for a DB instance.
pub const AwsRdsDbParameterGroup = struct {
    /// The name of the parameter group.
    db_parameter_group_name: ?[]const u8,

    /// The status of parameter updates.
    parameter_apply_status: ?[]const u8,

    pub const json_field_names = .{
        .db_parameter_group_name = "DbParameterGroupName",
        .parameter_apply_status = "ParameterApplyStatus",
    };
};
