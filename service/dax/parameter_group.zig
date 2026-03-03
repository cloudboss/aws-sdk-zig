/// A named set of parameters that are applied to all of the nodes in a DAX
/// cluster.
pub const ParameterGroup = struct {
    /// A description of the parameter group.
    description: ?[]const u8 = null,

    /// The name of the parameter group.
    parameter_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .parameter_group_name = "ParameterGroupName",
    };
};
