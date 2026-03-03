/// The status of a parameter group.
pub const ParameterGroupStatus = struct {
    /// The node IDs of one or more nodes to be rebooted.
    node_ids_to_reboot: ?[]const []const u8 = null,

    /// The status of parameter updates.
    parameter_apply_status: ?[]const u8 = null,

    /// The name of the parameter group.
    parameter_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .node_ids_to_reboot = "NodeIdsToReboot",
        .parameter_apply_status = "ParameterApplyStatus",
        .parameter_group_name = "ParameterGroupName",
    };
};
